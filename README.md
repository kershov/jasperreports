# JasperReports Server 7.5.0 Community Edition for Docker

## Introduction

This is a customized version of the [js-docker](https://github.com/TIBCOSoftware/js-docker) repository that allows to run **TIBCO JasperReports Server Community Edition** with **PostgreSQL**.

**Inspired by:** [@Robinyo](https://github.com/Robinyo) / [js-docker]( https://github.com/Robinyo/js-docker/).

## Installation

**Step 1:** Download JasperReports Server 7.5.0 Community Edition by running the following script:

```bash
$ ./jrs-download.sh
```

## Building

**Step 2:** Build the project by running the following command:

```bash
$ docker-compose build
```

## Serving

**Step 3:** Run the following command to serve the project daemonized:

```bash
$ docker-compose up -d
```

Your application will be served at: http://127.0.0.1:8080 (http://127.0.0.1:8080/jasperreports)

**Credentials:**

- Admin: `jasperadmin` / `jasperadmin`
- User: `joeuser` / `joeuser`

**Check status:**

```bash
$ docker-compose ps
```

**Stop containers:**

```bash
$ docker-compose stop
```

**Stop and remove containers, as well as any networks that were created:**

```bash
$ docker-compose down
```

**Full blown reset on your environment with removing all the volumes too:**

```bash
$ docker-compose down -v 
```

## Modifications

### SMTP

To setup SMTP, run the following command:

```bash
cp js-docker/smtp.env.example js-docker/smtp.env
```

And fill in your settings and credentials.

Modified "`js-docker/scripts/entrypoint-ce.sh`" to apply SMTP-settings from environment variables:

```bash
apply_smtp_settings() {
	# ...
}
```

### Security

**WARNING!!!** Potentially risky!

By default you can query your data sources only with `SELECT` statement. Disabled to be able to use `WITH` statements as well.

Modified "`js-docker/scripts/entrypoint-ce.sh`":

```bash
apply_security_settings() {
	# ...
}
```

### Other

Added redirect from `http://127.0.0.1:8080` to `http://127.0.0.1:8080/jasperreports`.
