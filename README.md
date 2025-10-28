# ScanCentral DAST Sensor
## ❓ Description

This repo contains the files required for a Podman Fortify ScanCentral DAST Scanner / Sensor deployment.

## 🎉 Deployment

### 🐳 Offline image retrival

If you plan to deploy this component on an offline environment, below are the commands to save the container image for loading in the destination environment
1. First login to Docker Hub using your Docker Hub credentials
```
podman login docker.io
```
2. Then save the image locally
```
# 1. DAST Scanner
podman pull fortifydocker/dast-scanner:25.2.ubi.9
podman save fortifydocker/dast-scanner:25.2.ubi.9 -o fortifydocker_dast-scanner_25.2.ubi.9.tar

# 2. Scanner Service
podman pull fortifydocker/scancentral-dast-scannerservice:25.2.ubi.9
podman save fortifydocker/scancentral-dast-scannerservice:25.2.ubi.9 -o fortifydocker_scancentral-dast-scannerservice_25.2.ubi.9.tar

# 3. WISE
podman pull fortifydocker/wise:25.2.ubi.9
podman save fortifydocker/wise:25.2.ubi.9 -o fortifydocker_wise_25.2.ubi.9.tar

# 4. MS SQL Server Datastore
podman pull mcr.microsoft.com/mssql/server:2022-latest
podman save mcr.microsoft.com/mssql/server:2022-latest -o mcr.microsoft.com_mssql_server_2022-latest.tar

# 5. Fortify 2FA (Optional)
podman pull fortifydocker/fortify-2fa:25.2.ubi.9
podman save fortifydocker/fortify-2fa:25.2.ubi.9 -o fortifydocker_fortify-2fa_25.2.ubi.9.tar
```
3. Get this tar file in the destination environment, and load it
```
podman load -i fortifydocker_dast-scanner_25.2.ubi.9.tar
podman load -i fortifydocker_scancentral-dast-scannerservice_25.2.ubi.9.tar
podman load -i fortifydocker_wise_25.2.ubi.9.tar
podman load -i mcr.microsoft.com_mssql_server_2022-latest.tar
podman load -i fortifydocker_fortify-2fa_25.2.ubi.9.tar
```


### 🐳 Deployment

1. Login to Docker Hub using your Docker Hub credentials
```
podman login docker.io -u
```

2. Copy or rename [.env.template](.env.template) to `.env`. 
3. Review and edit the `.env` file
4. Update the image tag the `DOCKER_IMAGE_XXX` variables in `.env`
5. Run the following command
```
podman-compose up -d

# You can tail the logs using the following command
podman-compose logs -f
```

### 🌡️ Environment variables
| Name                                   | Description                                                                                     | Example                                                   |
|----------------------------------------|-------------------------------------------------------------------------------------------------|-----------------------------------------------------------|
| DOCKER_IMAGE_SCANNER                  | Docker image used for the DAST scanner service                                                | `fortifydocker/dast-scanner:25.2.ubi.9`                 |
| DOCKER_IMAGE_SCANNERSERVICE           | Docker image used for the ScanCentral DAST Scanner Service                                    | `fortifydocker/scancentral-dast-scannerservice:25.2.ubi.9` |
| DOCKER_IMAGE_WISE                     | Docker image used for the WISE service                                                        | `fortifydocker/wise:25.2.ubi.9`                         |
| DOCKER_IMAGE_DATASTORE                | Docker image for the MSSQL datastore                                                          | `mcr.microsoft.com/mssql/server:2022-latest`            |
| DOCKER_IMAGE_2FA                      | Docker image for the Fortify 2FA service                                                      | `fortifydocker/fortify-2fa:25.2.ubi.9`                  |
| DOCKER_HOST_VOLUME_SECRETS            | Host path to mount as a volume for secrets inside the Docker container                        | `./volumes/secrets`                                      |
| DOCKER_HOST_VOLUME_DATA               | Host path for persistent scan data inside the Docker container                                | `scandata`                                               |
| DAST_DB_MSSQL_SA_PASSWORD             | MSSQL SA password for the local database                                                      | `One4All@1234`                                           |
| DAST_API_HOST                         | Hostname for ScanCentral DAST API                                                             | `scancentral-dast-api`                                   |
| DAST_API_HOST_PORT                    | Port for ScanCentral DAST API                                                                 | `8443`                                                   |
| DAST_SERVICE_TOKEN                    | Service token for accessing DAST services                                                     | `One4All@1234`                                           |
| DAST_API_ALLOW_NON_TRUSTED_CERTS      | Allow non-trusted SSL certificates for DAST API                                               | `true`                                                   |
| DAST_API_CLIENT_CERTIFICATE_ENABLED   | Enable client certificate authentication for DAST API                                         | `false`                                                  |
| DAST_API_CLIENT_CERTIFICATE_PATH      | Path to the client certificate for DAST API                                                   | `/app/secrets/certificates/dast-scanner-api-client-certificate` |
| DAST_API_CLIENT_CERTIFICATE_PASSWORD  | Password for the client certificate (if applicable)                                           |                                                 |
| WI_API_TLS_ENABLED                    | Enable TLS for WISE API                                                                       | `false`                                                  |
| WI_API_AUTH_TYPE                      | Authentication type for WISE API                                                              | `None`                                                   |
| WI_API_USERNAME                       | Username for WISE API authentication                                                          |                                                 |
| WI_API_PASSWORD                       | Password for WISE API authentication                                                          |                                                 |
| WI_USE_PROXY                          | Enable proxy for WI                                                                           | `false`                                                  |
| WI_PROXY_ADDRESS                      | Proxy address for WI                                                                          |                                                 |
| WI_PROXY_USERNAME                     | Proxy username for WI                                                                         |                                                 |
| WI_PROXY_PASSWORD                     | Proxy password for WI                                                                         |                                                 |
| WI_PROXY_BYPASS_LIST                  | List of addresses to bypass proxy                                                             |                                                 |
| WI_PROXY_BYPASS_ON_LOCAL              | Bypass proxy for local addresses                                                              | `true`                                                   |
