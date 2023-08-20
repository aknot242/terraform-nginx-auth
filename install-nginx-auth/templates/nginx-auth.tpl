---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-auth
spec:
  selector:
    matchLabels:
      app: nginx-auth
  template:
    metadata:
      labels:
        app: nginx-auth
    spec:
      containers:
        - image: ghcr.io/aknot242/nginx-oidc:latest
          imagePullPolicy: IfNotPresent
          name: nginx-oidc
          ports:
            - containerPort: 8080
              protocol: TCP
            - containerPort: 4443
              protocol: TCP
          volumeMounts:
            - mountPath: /nginx-zones
              name: nginx-zones
            - mountPath: /nginx-tmp
              name: nginx-tmp
            - mountPath: /nginx-cache
              name: nginx-cache
            - mountPath: /nginx/etc/nginx/conf.d/frontend.conf
              subPath: frontend.conf
              name: frontend
              readOnly: true
            - mountPath: /nginx/etc/nginx/conf.d/openid_connect_configuration.conf
              subPath: openid_connect_configuration.conf
              name: openid-connect-configuration
              readOnly: true
            - mountPath: /nginx/etc/nginx/conf.d/openid_connect.server_conf
              subPath: openid_connect.server_conf
              name: openid-connect-server-conf
              readOnly: true
            - mountPath: /nginx/etc/ssl
              name: nginx-tls
              readOnly: true
      imagePullSecrets:
        - name: ghcr
      volumes:
        - configMap:
            name: frontend
          name: frontend
        - secret:
            secretName: openid-connect-configuration
          name: openid-connect-configuration
        - configMap:
            name: openid-connect-server-conf
          name: openid-connect-server-conf
        - emptyDir:
            sizeLimit: 1Gi
          name: nginx-zones
        - emptyDir:
            sizeLimit: 10Mi
          name: nginx-tmp
        - emptyDir:
            sizeLimit: 100Mi
          name: nginx-cache
        - secret:
            secretName: nginx-tls
          name: nginx-tls

---
apiVersion: v1
kind: Service
metadata:
  name: nginx-auth
spec:
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 8080
    - name: https
      port: 443
      protocol: TCP
      targetPort: 4443
  selector:
    app: nginx-auth
  type: ClusterIP

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: frontend
data:
  frontend.conf: |
    log_format main_jwt '$host - $remote_addr - $jwt_claim_sub [$time_local] "$request" $status '
                        '$body_bytes_sent "$http_referer" "$http_user_agent" "$http_x_forwarded_for"';
    server {
        listen 4443 ssl default_server;
        ssl_certificate /nginx/etc/ssl/tls.crt;
        ssl_certificate_key /nginx/etc/ssl/tls.key;
        include conf.d/openid_connect.server_conf; # Authorization code flow and Relying Party processing
        error_log /nginx/var/log/nginx/error.log debug;  # Reduce severity level as required

        location / {
            set $upstream_host_name ${proxied_app_fqdn};
            auth_jwt "" token=$session_jwt;
            error_page 401 = @do_oidc_flow;
            auth_jwt_key_request /_jwks_uri;
            proxy_ssl_server_name on;
            proxy_ssl_name $upstream_host_name;
            proxy_set_header Host $upstream_host_name;
            proxy_pass https://$upstream_host_name;
            access_log /nginx/var/log/nginx/access.log main_jwt;
        }
    }

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: openid-connect-server-conf
data:
  openid_connect.server_conf: |
    set $internal_error_message "NGINX / OpenID Connect login failure\n";
    set $pkce_id "";
    resolver 8.8.8.8; # Using Google server For DNS lookup of IdP endpoints;
    subrequest_output_buffer_size 32k; # To fit a complete tokenset response
    gunzip on; # Decompress IdP responses if necessary
    location = /_jwks_uri {
        internal;
        proxy_cache jwk;                              # Cache the JWK Set recieved from IdP
        proxy_cache_valid 200 12h;                    # How long to consider keys "fresh"
        proxy_cache_use_stale error timeout updating; # Use old JWK Set if cannot reach IdP
        proxy_ssl_server_name on;                     # For SNI to the IdP
        proxy_method GET;                             # In case client request was non-GET
        proxy_set_header Content-Length "";           # ''
        proxy_pass $oidc_jwt_keyfile;                 # Expecting to find a URI here
        proxy_ignore_headers Cache-Control Expires Set-Cookie; # Does not influence caching
    }
    location @do_oidc_flow {
        status_zone "OIDC start";
        js_content oidc.auth;
        default_type text/plain; # In case we throw an error
    }
    set $redir_location "/_codexch";
    location = /_codexch {
        status_zone "OIDC code exchange";
        js_content oidc.codeExchange;
        error_page 500 502 504 @oidc_error; 
    }
    location = /_token {
        internal;
        proxy_ssl_server_name on; # For SNI to the IdP
        proxy_set_header      Content-Type "application/x-www-form-urlencoded";
        proxy_set_body        "grant_type=authorization_code&client_id=$oidc_client&$args&redirect_uri=$redirect_base$redir_location";
        proxy_method          POST;
        proxy_pass            $oidc_token_endpoint;
    }
    location = /_refresh {
        internal;
        proxy_ssl_server_name on; # For SNI to the IdP
        proxy_set_header      Content-Type "application/x-www-form-urlencoded";
        proxy_set_body        "grant_type=refresh_token&refresh_token=$arg_token&client_id=$oidc_client&client_secret=$oidc_client_secret";
        proxy_method          POST;
        proxy_pass            $oidc_token_endpoint;
    }
    location = /_id_token_validation {
        internal;
        auth_jwt "" token=$arg_token;
        js_content oidc.validateIdToken;
        error_page 500 502 504 @oidc_error;
    }

    location = /logout {
        status_zone "OIDC logout";
        add_header Set-Cookie "auth_token=; $oidc_cookie_flags"; # Send empty cookie
        add_header Set-Cookie "auth_redir=; $oidc_cookie_flags"; # Erase original cookie
        js_content oidc.logout;
    }
    location = /_logout {
        default_type text/plain;
        return 200 "Logged out\n";
    }

    location @oidc_error {
        status_zone "OIDC error";
        default_type text/plain;
        return 500 $internal_error_message;
    }

---
apiVersion: v1
kind: Secret
metadata:
  name: openid-connect-configuration
stringData:
  openid_connect_configuration.conf: |
    map $host $oidc_authz_endpoint {
        default "https://login.microsoftonline.com/${azure_directory_id}/oauth2/v2.0/authorize";
    }
    map $host $oidc_token_endpoint {
        default "https://login.microsoftonline.com/${azure_directory_id}/oauth2/v2.0/token";
    }
    map $host $oidc_jwt_keyfile {
        default "https://login.microsoftonline.com/${azure_directory_id}/discovery/v2.0/keys";
    }
    map $host $oidc_client {
        default "${azure_oidc_client_id}";
    }
    map $host $oidc_pkce_enable {
        default 0;
    }
    map $host $oidc_client_secret {
        default "${azure_oidc_client_secret}";
    }
    map $host $oidc_scopes {
        default "email+openid+profile";
    }
    map $host $oidc_logout_redirect {
        default "/_logout"; # Built-in, simple logout page
    }
    map $host $oidc_hmac_key {
        default "${azure_oidc_hmac_key}";
    }
    map $host $zone_sync_leeway {
        default 0; # Time in milliseconds, e.g. (zone_sync_interval * 2 * 1000)
    }
    map $proto $oidc_cookie_flags {
        http  "Path=/; SameSite=lax;"; # For HTTP/plaintext testing
        https "Path=/; SameSite=lax; HttpOnly; Secure;"; # Production recommendation
    }
    map $http_x_forwarded_port $redirect_base {
        ""      $proto://$host:$server_port;
        default $proto://$host:$http_x_forwarded_port;
    }
    map $http_x_forwarded_proto $proto {
        ""      $scheme;
        default $http_x_forwarded_proto;
    }
    proxy_cache_path /nginx-cache/jwk levels=1 keys_zone=jwk:64k max_size=1m;
    keyval_zone zone=oidc_id_tokens:1M state=/nginx-zones/oidc_id_tokens.json timeout=1h;
    keyval_zone zone=refresh_tokens:1M state=/nginx-zones/refresh_tokens.json timeout=8h;
    keyval_zone zone=oidc_pkce:128K timeout=90s; # Temporary storage for PKCE code verifier.
    keyval $cookie_auth_token $session_jwt zone=oidc_id_tokens;   # Exchange cookie for JWT
    keyval $cookie_auth_token $refresh_token zone=refresh_tokens; # Exchange cookie for refresh token
    keyval $request_id $new_session zone=oidc_id_tokens; # For initial session creation
    keyval $request_id $new_refresh zone=refresh_tokens; # ''
    keyval $pkce_id $pkce_code_verifier zone=oidc_pkce;
    auth_jwt_claim_set $jwt_audience aud; # In case aud is an array
    js_import oidc from conf.d/openid_connect.js;