# Nexus

> Smart home server configuration

## Install

- review and customize the files in the `config` folder:
  - In `.bashrc`: `NEXUS_PROJECT_PATH` environment variable
  - In `.gitconfig`: user and email
- run `sudo bash config/install.sh`. Sudo is needed to deploy `sshd_config`. Without sudo the install script will just update `bashrc` and `gitconfig`

## Usage

- an `nx` command is available to manage your docker compose project. Run `nx help` to learn more
- a `dk` command aliases `sudo docker` for manual actions