# Forecastr

Sandbox weather app. WIP.

### In a nushell

- this app is an `elm` playground
- it aims at taking the redux version of [forecastr app](https://github.com/slyg/forecastr-app) and see how it can be re-implemented using elm
- it actually doesn't follow <abbr title="The Elm Architecture">TEA</abbr> :-/

### Install and build locally

Create build environment:

```bash
$ docker build -t build-env -f ./Dockerfile.build .
```

Trigger a build:

```bash
$ docker run -v $(pwd)/public:/web/public build-env
```

### Serve

```bash
$ docker-compose up --build
```
Serves application at [http://localhost:9000](http://localhost:9000).

Note: Built files are located in `/public`, you can also serve them using `http-server`.
