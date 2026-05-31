# Script de Infraestrutura Base Linux
[🇺🇸 English](README.md) | 🇧🇷 Português

## Descrição

Este script Bash provisiona uma infraestrutura base no Linux, criando grupos, diretórios, permissões, regras de propriedade e usuários.

Ele pode ser usado para configuração inicial de servidores, laboratórios ou prática simples de Infrastructure as Code (IaC).

## O que o script faz

- Verifica se está sendo executado com privilégios de root
- Cria grupos de administração, vendas e segurança
- Cria diretórios base
- Aplica permissões em cada diretório
- Define o grupo proprietário dos diretórios restritos
- Cria usuários com nome de exibição
- Adiciona usuários aos seus respectivos grupos
- Define uma senha inicial para cada usuário
- Força a alteração da senha no primeiro login

## Grupos criados

| Grupo | Descrição |
|---|---|
| `GRP_ADM` | Grupo administrativo |
| `GRP_VEN` | Grupo de vendas |
| `GRP_SEC` | Grupo de segurança |

## Diretórios criados

| Diretório | Permissão | Grupo proprietário |
|---|---:|---|
| `/publico` | `777` | `root` |
| `/adm` | `770` | `GRP_ADM` |
| `/ven` | `770` | `GRP_VEN` |
| `/sec` | `770` | `GRP_SEC` |

## Usuários

| Usuário | Nome de exibição | Grupos |
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

## Requisitos

- Sistema Linux
- Bash
- Privilégios de root
- `openssl` instalado

## Como usar

Dê permissão de execução:

```bash
chmod +x script.sh
```

Execute como root:

```bash
sudo ./script.sh
```

## Regra da senha inicial

Cada usuário recebe uma senha inicial baseada nas três primeiras letras do nome de usuário seguidas de `1234`.

Exemplo:

```txt
leonardo -> leo1234
carlos   -> car1234
```

A senha é expirada imediatamente após a criação do usuário, obrigando a alteração no primeiro login.

## Observações

Este script é parcialmente idempotente. Ele verifica se grupos, diretórios e usuários já existem antes de criá-los.

Porém, permissões, propriedades e vínculos com grupos são aplicados sempre que o script é executado.
