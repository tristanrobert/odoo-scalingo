# odoo-scalingo

> [Odoo](https://odoo.com) scalingo app

## Hacking

You set environment variables in `.env`:

```shell
cp .env.sample .env
```

Run an interactive docker scalingo stack:

```shell
docker run --name odoo -it -p 8080:8080 -v "$(pwd)"/.env:/env/.env -v "$(pwd)":/buildpack -v "$(pwd)"/.buildpacks:/build/.buildpacks -v "$(pwd)"/Aptfile:/build/Aptfile -v "$(pwd)"/runtime.txt:/build/runtime.txt scalingo/scalingo-20:latest bash
```

And test in it (see [Dockerfile](Dockerfile)):

```shell
bash buildpack/bin/env.sh /env/.env /env
git clone https://github.com/Scalingo/multi-buildpack
bash multi-buildpack/bin/compile /build /cache /env
rm -rf /app/*
rsync -av build/ app/ --exclude=".scalingo"
/app/bin/run
```

You can also use docker-compose in order to test with a complete stack (db):

```shell
docker-compose up --build -d
docker-compose down -v
```
