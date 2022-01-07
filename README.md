# odoo-scalingo

> Odoo scalingo app

## Hacking

You set environment variables in `.env`:

```shell
cp .env.sample .env
```

Run an interactive docker scalingo stack:

```shell
docker run --name odoo -it -p 8080:8080 -v "$(pwd)"/.env:/env/.env -v "$(pwd)":/buildpack scalingo/scalingo-18:latest bash
```

And test in it:

```shell
bash buildpack/bin/detect
bash buildpack/bin/env.sh /env/.env /env
bash buildpack/bin/compile /build /cache /env
bash buildpack/bin/release
```
