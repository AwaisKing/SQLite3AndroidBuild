# SQLite auto build for Android

This repository contains a workflow to generate the following of the latest SQLite artifacts for Android:
- Statically Linked CLI (`sqlite3-static`)
- Dynamically Linked CLI (`sqlite3-dynamic`)
- Static Library (`libsqlite3.a`)
- Dynamically Linked Shared Object Library (`libsqlite3.so`)

The compilation generates binaries for the following ABIs (each in a separate folder): `armeabi-v7a`, `arm64-v8a`, `x86`, `x86_64`.

---
# How to download

1. Go to actions
2. Go to the latest build
3. Scroll to artifacts
4. Click on "Download" button

---
thanks to:

https://github.com/stockrt/sqlite3-android

https://github.com/jacopotediosi/sqlite3-android
