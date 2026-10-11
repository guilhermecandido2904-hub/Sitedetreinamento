#!/usr/bin/env bash
# Gera o APK de teste (debug) do Gemini Fit. Requer: Node 18+, JDK 17+ e Android SDK (ANDROID_HOME).
set -euo pipefail
cd "$(dirname "$0")"
if grep -q "SEU-SITE" capacitor.config.json; then echo "Edite capacitor.config.json: troque https://SEU-SITE.netlify.app pelo endereço real do site."; exit 1; fi
npm install
[ -d android ] || npx cap add android
npm run icons
npx cap sync android
(cd android && ./gradlew assembleDebug)
mkdir -p dist && cp android/app/build/outputs/apk/debug/app-debug.apk dist/gemini-fit.apk
echo "Pronto: dist/gemini-fit.apk"
