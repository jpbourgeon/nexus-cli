# Nexus

> An opinionated subset of preconfigured docker compose commands to manage applications and services.

## Docker compose convention

- As of now, the cli is mono project. It targets a single docker-compose.yaml file.
- Services should use profiles to group related services. The "all" profile is expected to be set on every services. 

### Volumes

- Bound volumes allow direct access to the host's file system or existing directories on the host. Docker and Docker Compose will not delete the underlying storage folders specified by the host path.
  ```    
  volumes:
        - ${NEXUS_DATA}/<folder_name>:/config
  ```
- Named Docker volumes bind to the host using the local driver and the specified device path. Docker and Docker Compose do not delete the underlying storage folders in this setup either.
  ```    
  # https://stackoverflow.com/a/49920624
  volumes:
    <service-vol>:
        driver: local
        driver_opts:
          type: none
          o: bind
          device: ${NEXUS_DATA}/<folder_name>
  ```

## Installation

- review and customize the files in the `config` folder:
  - In `.bashrc`: `NEXUS_CLI` `NEXUS_SVC` environment variable
  - In `.gitconfig`: user and email
- run `sudo bash config/install.sh`. Sudo is needed to deploy `sshd_config` and install the `jq` package dependency. Without sudo the install script will just update `bashrc` and `gitconfig`

## Cli Usage

- `nx` command: manage your docker compose project. Run `nx help` to learn more
- `_nx` alias for `sudo docker compose -f "$NEXUS_SVC/docker-compose.yml"`
- `dk` alias for `sudo docker`

