# Nexus

> An opinionated subset of preconfigured docker compose commands to manage applications and services.

## Docker compose convention

- As of now, the cli is mono project. It targets a single docker-compose.yaml file.
- Services should use profiles to group related services. The "all" should 

## Installation

- review and customize the files in the `config` folder:
  - In `.bashrc`: `NEXUS_CLI` `NEXUS_SVC` `NEXUS_VOL` environment variable
  - In `.gitconfig`: user and email
- run `sudo bash config/install.sh`. Sudo is needed to deploy `sshd_config`. Without sudo the install script will just update `bashrc` and `gitconfig`

## Cli Usage

- an `nx` command is available to manage your docker compose project. Run `nx help` to learn more
- a `dk` command aliases `sudo docker` for manual actions