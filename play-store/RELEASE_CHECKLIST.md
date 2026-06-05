# Checklist de Publicacao — OptiCalc Pro

## Pre-build

- [x] Package name definido: `com.opticalcpro.opticalc_pro`
- [x] Versao: `1.0.0+1` (versionName 1.0.0, versionCode 1)
- [x] Assinatura release configurada (`android/key.properties` + keystore)
- [x] Permissoes INTERNET e ACCESS_NETWORK_STATE
- [x] Nome do app: "OptiCalc Pro"

## Build

```bash
# Gerar keystore (apenas na primeira vez)
./scripts/generate_keystore.sh

# Gerar AAB + APK assinados
./scripts/build_release.sh
```

Artefatos gerados em `release/`:
- `opticalc-pro-1.0.0.aab` — enviar ao Google Play Console
- `opticalc-pro-1.0.0.apk` — distribuicao direta / testes

## Google Play Console

1. Criar app em https://play.google.com/console
2. Ativar **Play App Signing** (recomendado)
3. Enviar o arquivo `.aab` em **Producao** ou **Teste interno**
4. Preencher listagem com textos de `listing-pt-BR.md`
5. Publicar politica de privacidade (`PRIVACY_POLICY.md`) em URL publica
6. Preencher formulario de **Seguranca de dados**
7. Responder questionario de **Classificacao de conteudo**
8. Adicionar screenshots (minimo 2) e icone 512x512
9. Definir paises de distribuicao (Brasil recomendado)
10. Enviar para revisao

## Apos publicacao

- Guardar o keystore (`android/keystore/upload-keystore.jks`) em local seguro
- Incrementar `versionCode` a cada nova versao no `pubspec.yaml`
- Nunca perder o keystore de upload — necessario para atualizacoes

## Credenciais de assinatura (ambiente de build)

O keystore foi gerado no ambiente de build. Consulte o responsavel pelo deploy para obter:
- Arquivo `upload-keystore.jks`
- Senhas em `android/key.properties`

Para regenerar em maquina local, use `scripts/generate_keystore.sh`.
