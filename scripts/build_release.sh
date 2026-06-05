#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RELEASE_DIR="${ROOT_DIR}/release"
KEY_PROPERTIES="${ROOT_DIR}/android/key.properties"

cd "${ROOT_DIR}"

if [[ ! -f "${KEY_PROPERTIES}" ]]; then
  echo "Arquivo android/key.properties nao encontrado."
  echo "Execute scripts/generate_keystore.sh ou copie android/key.properties.example."
  exit 1
fi

echo "==> Validando projeto"
flutter pub get
flutter analyze
flutter test

mkdir -p "${RELEASE_DIR}"

echo "==> Gerando App Bundle (AAB) para Play Store"
flutter build appbundle --release
cp "${ROOT_DIR}/build/app/outputs/bundle/release/app-release.aab" \
  "${RELEASE_DIR}/opticalc-pro-1.0.0.aab"

echo "==> Gerando APK para distribuicao direta"
flutter build apk --release
cp "${ROOT_DIR}/build/app/outputs/flutter-apk/app-release.apk" \
  "${RELEASE_DIR}/opticalc-pro-1.0.0.apk"

echo ""
echo "Arquivos gerados:"
echo "  Play Store (AAB): ${RELEASE_DIR}/opticalc-pro-1.0.0.aab"
echo "  APK direto:       ${RELEASE_DIR}/opticalc-pro-1.0.0.apk"
echo ""
echo "Envie o arquivo .aab no Google Play Console."
