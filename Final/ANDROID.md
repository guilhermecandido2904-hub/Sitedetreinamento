# Gemini Fit — APK para Android

**Estado:** o projeto está pronto para gerar o APK, mas o APK **ainda não foi gerado nem testado** (o ambiente onde isto foi preparado não tem acesso ao Android SDK). O botão "Baixar para Android" só aparece no site depois que o arquivo existir em `public/downloads/gemini-fit.apk`.

## Como funciona
O app é um Capacitor (WebView) que abre o seu site publicado (`server.url`). Assim o site e o Supabase continuam iguais, login e sessão persistem, e atualizações do site chegam ao app sem gerar novo APK. Sem internet, mostra `www/offline.html`. Dentro do app o "Entrar com Google" fica oculto (o Google bloqueia login em WebView; use e-mail e senha) e o aviso de instalar PWA não aparece.
Pacote: `com.geminifit.app` · Nome: Gemini Fit · Ícone e splash: gerados de `assets/` (seu logo).

## 1. Gerar o APK (escolha um)
Antes, edite `capacitor.config.json`: troque `https://geminifit.app` pelo endereço real do site.

**A) GitHub (sem instalar nada):** envie esta pasta ao repositório > aba **Actions** > "APK Gemini Fit" > **Run workflow**. Ao terminar, baixe o artefato `gemini-fit-apk`.
**B) No seu computador:** instale Node 18+, JDK 17 e Android Studio (SDK) e rode `./build-android.sh` (Git Bash no Windows). Saída: `dist/gemini-fit.apk`. Também dá para rodar `npx cap open android` e usar Build > Build APK(s).

## 2. APK assinado para distribuir
O APK "teste" (debug) instala, mas para distribuir use uma chave sua, **guardada para sempre** (sem a mesma chave, o Android não aceita atualizações):
`keytool -genkeypair -v -keystore gemini.jks -alias gemini -keyalg RSA -keysize 2048 -validity 10000`
No GitHub, em Settings > Secrets > Actions, crie `KEYSTORE_BASE64` (conteúdo de `base64 gemini.jks`), `KEYSTORE_PASSWORD` e `KEY_ALIAS`. A próxima execução também gera `gemini-fit.apk` assinado. Nunca envie o `.jks` ao repositório.

## 3. Publicar no site
Copie o APK assinado para `public/downloads/gemini-fit.apk` e faça o deploy normal. O botão "Baixar para Android" aparece sozinho para quem abre o site no Android. Confira: `https://SEU-SITE/downloads/gemini-fit.apk` deve baixar o arquivo.

## 4. O que o usuário vai ver
1. Toca em "Baixar para Android"; o Chrome avisa que "este tipo de arquivo pode ser perigoso" > **Manter/Baixar mesmo assim**.
2. Ao abrir o arquivo, o Android pede para permitir "Instalar apps desconhecidos" para o Chrome (ou navegador usado) > **Permitir desta fonte**.
3. Toca em **Instalar**. O Play Protect pode avisar que o app não é conhecido > **Instalar mesmo assim** (normal para apps fora da Play Store).
Permissões do app: apenas internet.

## Teste no celular (checklist)
Instalar; abrir (ícone/nome/splash); criar conta e entrar com e-mail/senha; fechar e reabrir (sessão mantida); ver treinos; tocar em um vídeo de aula; modo avião (deve mostrar a tela "Sem conexão"); admin e personal.
