#!/bin/bash
echo "⚙️  Script Version: 1.9"

if [ "${ARCH}" == "x86_64" ];
then
    echo "🔎  Identified Architecture: 64x"
    if [[ -f "./mta-server64" ]]; then
        echo "✅  Starting MTA"
        ./mta-server64 --maxplayers ${MAX_PLAYERS} --port ${SERVER_PORT} --httpport ${SERVER_WEBPORT} -n
    else
        echo "pt-BR: MTA Não Instalado, isso é realmente muito estranho, essa é uma segunda verificação."
        echo "en: MTA Not Installed, this is really very strange, this is a second check."
    fi
else
    echo "🔎  Identified Architecture: ARM64"
    if [[ -f "./mta-server-arm64" ]]; then
        echo "✅  Starting MTA"
        ./mta-server-arm64 --maxplayers ${MAX_PLAYERS} --port ${SERVER_PORT} --httpport ${SERVER_WEBPORT} -n
    else
        echo "pt-BR: MTA Não Instalado, isso é realmente muito estranho, essa é uma segunda verificação."
        echo "en: MTA Not Installed, this is really very strange, this is a second check."
    fi
fi
