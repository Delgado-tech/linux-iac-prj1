# Linux Base Infrastructure Script
🇺🇸 English | [🇧🇷 Português](README.pt-BR.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Description

This Bash script provisions a basic Linux infrastructure by creating groups, directories, permissions, ownership rules, and users.

It is intended for initial server setup, labs, or simple Infrastructure as Code (IaC) practice.

## What the script does

- Checks if it is running with root privileges
- Creates administrative, sales, and security groups
- Creates base directories
- Applies permissions to each directory
- Sets group ownership for restricted directories
- Creates users with display names
- Adds users to their respective groups
- Defines an initial password for each user
- Forces password change on first login

## Created groups

| Group | Description |
|---|---|
| `GRP_ADM` | Administrative group |
| `GRP_VEN` | Sales group |
| `GRP_SEC` | Security group |

## Created directories

| Directory | Permission | Group owner |
|---|---:|---|
| `/publico` | `777` | `root` |
| `/adm` | `770` | `GRP_ADM` |
| `/ven` | `770` | `GRP_VEN` |
| `/sec` | `770` | `GRP_SEC` |

## Users

| Username | Display name | Groups |
|---|---|---|
| `leonardo` | Leonardo Delgado | `GRP_ADM`, `GRP_VEN`, `GRP_SEC` |
| `debora` | Debora Silva | `GRP_ADM`, `GRP_VEN` |
| `rogerio` | Rogério Gomes | `GRP_ADM` |
| `josefina` | Josefina Florisbela | `GRP_ADM` |
| `carlos` | Carlos Silva Pedroso | `GRP_VEN` |
| `maria` | Maria Eduarda | `GRP_VEN` |
| `amanda` | Amanda Figueredo | `GRP_VEN` |
| `joao` | João da Silva Rocha | `GRP_SEC` |
| `sebastiana` | Sebastiana Menezes | `GRP_SEC` |
| `roberto` | Roberto Carlos | `GRP_SEC` |

## Requirements

- Linux system
- Bash
- Root privileges
- `openssl` installed

## Usage

Give execution permission:

```bash
chmod +x script.sh
```

Run as root:

```bash
sudo ./script.sh
```

## Initial password rule

Each user receives an initial password based on the first three letters of their username followed by `1234`.

Example:

```txt
leonardo -> leo1234
carlos   -> car1234
```

The password is expired immediately after user creation, forcing the user to change it on first login.

## Notes

This script is partially idempotent. It checks whether groups, directories, and users already exist before creating them.

However, permissions, ownership, and group memberships are applied every time the script runs.
