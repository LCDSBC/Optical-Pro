#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
KEYSTORE_DIR="${ROOT_DIR}/android/keystore"
KEYSTORE_FILE="${KEYSTORE_DIR}/upload-keystore.jks"
KEY_PROPERTIES="${ROOT_DIR}/android/key.properties"

mkdir -p "${KEYSTORE_DIR}"

if [[ -f "${KEYSTORE_FILE}" ]]; then
  echo "Keystore ja existe em ${KEYSTORE_FILE}"
  exit 0
fi

read -r -p "Senha do keystore (storePassword): " STORE_PASSWORD
read -r -p "Senha da chave (keyPassword): " KEY_PASSWORD

keytool -genkeypair -v \
  -keystore "${KEYSTORE_FILE}" \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias upload \
  -storepass "${STORE_PASSWORD}" \
  -keypass "${KEY_PASSWORD}" \
  -dname "CN=OptiCalc Pro, OU=Development, O=OptiCalc Pro, L=Sao Paulo, ST=SP, C=BR"

cat > "${KEY_PROPERTIES}" <<EOF
storePassword=${STORE_PASSWORD}
keyPassword=${KEY_PASSWORD}
keyAlias=upload
storeFile=keystore/upload-keystore.jks
EOF

echo "Keystore criado em ${KEYSTORE_FILE}"
echo "Configuracao salva em ${KEY_PROPERTIES}"
