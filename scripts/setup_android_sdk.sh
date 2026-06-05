#!/usr/bin/env bash
set -euo pipefail

export ANDROID_HOME="${ANDROID_HOME:-$HOME/Android/Sdk}"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"

if [[ -d "$ANDROID_HOME/platforms/android-36" ]]; then
  echo "Android SDK ja configurado em ${ANDROID_HOME}"
  exit 0
fi

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

mkdir -p "$ANDROID_HOME/cmdline-tools"
wget -q https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip \
  -O "${TMP_DIR}/cmdline-tools.zip"
unzip -q "${TMP_DIR}/cmdline-tools.zip" -d "${TMP_DIR}/cmdline-tools"
mv "${TMP_DIR}/cmdline-tools/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest"

yes | sdkmanager --licenses >/dev/null
sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0"

flutter config --android-sdk "$ANDROID_HOME"
echo "Android SDK instalado em ${ANDROID_HOME}"
