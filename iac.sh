#!/bin/bash

# enable undefined variable alert (debug)
set -u

# Declare bash color codes
RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
RC="\e[0m"

# Check if script has executed with super user privileges
if [ "$EUID" -ne 0 ]
then
 	echo -e "${RED}A ação requer privilégios elevados! ${RC}"
	exit 1
fi

# Declare variables

# script delay per step (for make more readable steps)
stepDelay=1

# group names
grpAdm="GRP_ADM"
grpVen="GRP_VEN"
grpSec="GRP_SEC"

Groups=(
"$grpAdm"
"$grpVen"
"$grpSec"
)

# dirname:perm:groupOwner
Directories=(
"publico:777:root"
"adm:770:$grpAdm"
"ven:770:$grpVen"
"sec:770:$grpSec"
)

# username:displayname:groups[,]
Users=(
"leonardo:Leonardo Delgado:$grpAdm,$grpVen,$grpSec"
"debora:Debora Silva:$grpAdm,$grpVen"
"rogerio:Rogério Gomes:$grpAdm"
"josefina:Josefina Florisbela:$grpAdm"
"carlos:Carlos Silva Pedroso:$grpVen"
"maria:Maria Eduarda:$grpVen"
"amanda:Amanda Figueredo:$grpVen"
"joao:João da Silva Rocha:$grpSec"
"sebastiana:Sebastiana Menezes:$grpSec"
"roberto:Roberto Carlos:$grpSec"
)

echo "---------------------------------------------------------------------"
echo "# Iniciando execução de script de criação de infraestrutura base..."
echo "---------------------------------"

sleep "$stepDelay"

echo -e "${CYAN}# Executando criação de grupos ${RC}"
sleep "$stepDelay"

for group in "${Groups[@]}"
do
	# check if group dont exists
	if ! getent group "$group" >/dev/null 2>&1
	then
		groupadd "$group"
		echo -e "${GREEN}[+]${RC} grupo $group criado"
	else
		echo "[i] O grupo $group já existe"
	fi
done
echo "# Grupos criados com sucesso!"
echo "---------------------------------"
sleep "$stepDelay"

echo -e "${GREEN}# Executando criação de diretórios ${RC}"
sleep "$stepDelay"

for dir in "${Directories[@]}"
do
	IFS=":" read -r dirname perm grpowner <<< "$dir"

	# check if directory dont exists
	if ! [ -d "/$dirname" ]
	then
		mkdir -p "/$dirname"
		echo -e "${GREEN}[+]${RC} diretório $dirname criado"
	else
		echo "[i] O diretório $dirname já existe"
	fi

	chmod "$perm" "/$dirname"
	chown "root:$grpowner" "/$dirname"
	echo "[*] Atualizado perms e owner de /$dirname (root:$grpowner - $perm)"
	echo "---"
done
echo "# Diretórios criados com sucesso!"
echo "---------------------------------"
sleep "$stepDelay"

echo -e "${CYAN}# Executando criação de usuários ${RC}"
sleep "$stepDelay"

for user in "${Users[@]}"
do
	IFS=":" read -r username displayname usergroups <<< "$user"

	# check if user dont exists
	if ! id -un "$username" >/dev/null 2>&1
	then 
		useradd "$username" -m -c "$displayname" -s /bin/bash -p "$(openssl passwd -6 "${username:0:3}1234")"
		passwd -e "$username" >/dev/null
		echo -e "${GREEN}[+]${RC} usuário $displayname($username) criado"
	else
		echo "[i] O usuário $username já existe"
	fi

	usermod -aG "$usergroups" "$username"
	echo "[*] $displayname adicionado aos grupos $usergroups"
	echo "---"
done
echo "# Usuários criados com sucesso!"
echo "---------------------------------"
sleep "$stepDelay"

echo "# Script finalizado."
echo "---------------------------------"
