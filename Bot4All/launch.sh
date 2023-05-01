#!/bin/bash
bold=$(echo -en "\e[1m")
lightblue=$(echo -en "\e[94m")
normal=$(echo -en "\e[0m")

bash <(curl -s https://raw.githubusercontent.com/Ashu11-A/Ashu_eggs/main/Bot4All/nvm.sh)

echo "🔎  Pacotes Instalados: 
iproute2 tzdata curl git
jq file unzip wget ncurses
build-base ca-certificates 
libressl-dev nvm node npm bash"

if [ "${SERVER_IP}" = "0.0.0.0" ]; then
    MGM="na porta ${SERVER_PORT}"
else
    MGM="em ${SERVER_IP}:${SERVER_PORT}"
fi
echo "🟢  Estou rodando ${MGM}..."

if [[ -d .git ]] || [[ {{AUTO_UPDATE}} == "1" ]]; then
    echo "Executando: git pull"
    git pull
fi

(
    cd "./[seu_bot]" || exit

    if [[ ! -z ${NODE_PACKAGES} ]]; then
        npm install ${NODE_PACKAGES}
    fi

    if [[ ! -z ${UNNODE_PACKAGES} ]]; then
        npm uninstall ${UNNODE_PACKAGES}
    fi

    if [ -f /home/container/package.json ]; then
        npm install
    fi
)

if [ ! -f "logs/nodejs_version" ]; then
    printf "\n \n📝  Qual versão do nodejs você deseja utilizar (12, 14, 16, 18...) (pressione [ENTER]): \n \n"
    read VERSION
    echo "$VERSION" >logs/nodejs_version
    echo "👍  Blz, salvei a versão (v$VERSION) aqui!"
    echo "🫵  Você pode alterar a versão usando o comando: ${bold}${lightblue}version"
fi

echo "📃  Comandos Disponíveis: ${bold}${lightblue}help ${normal}, ${bold}${lightblue}version ${normal}, ${bold}${lightblue}npm ${normal}[your code] ou ${bold}${lightblue}node ${normal}[your code]..."

while read -r line; do
    start="$(cat logs/start-conf)"
    echo "✅  Auto reconexão ativada para prevenção de quedas..."
    nohup node "${start}" 2>&1 &
    sleep 1

    if [[ "$line" == "help" ]]; then
        echo "👀  Comandos Disponíveis:"
        echo "
+------------+---------------------------------------+
| Comando    |  O que Faz                            |
+------------+---------------------------------------+
| version    |  Troca a versão do Nodejs             |
| start-conf |  Troca a Inicialização do bot         |
| npm        |  Executa qualquer comando do npm      |
| node       |  Executa qualquer comando do nodejs   |
+------------+---------------------------------------+
        "
    elif [[ "$line" == *"npm"* ]]; then
        echo "Executando: ${bold}${lightblue}${line}"
        (
            cd "./[seu_bot]" || exit
            eval "$line"
        )
        printf "\n \n✅  Comando Executado\n \n"
    elif [[ "$line" == *"node"* ]]; then
        echo "Executando: ${bold}${lightblue}${line}"
        (
            cd "./[seu_bot]" || exit
            eval "$line"
        )
        printf "\n \n✅  Comando Executado\n \n"
    elif [[ "$line" == *"version"* ]]; then
        echo -n "📝  Qual versão do nodejs você deseja utilizar (12, 14, 16, 18...) (pressione [ENTER]): "
        read VERSION
        echo "$VERSION" >logs/nodejs_version
        echo "👌  OK, salvei a versão (v$VERSION) aqui!"
        exit
    elif [[ "$line" == *"start-conf"* ]]; then
        echo -n "📝  Qual é o arquivo de inicialização que você deseja utilizar? (bot.js, index.js...) (pressione [ENTER]): "
        read START
        echo "$START" >logs/start-conf
        echo "👌  OK, salvei ($START) aqui!"
        exit
    elif [[ "$line" != *"npm"* ]]; then
        echo "Comando Inválido. O que você está tentando fazer? Tente algo com ${bold}${lightblue}npm ${normal}ou ${bold}${lightblue}node."
    else
        echo "Script Falhou."
    fi
done
