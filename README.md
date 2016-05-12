# Forecastr

Sandbox weather app. WIP.

### In a nushell

- this app is an `elm` playground
- it aims at taking the redux version of [forecastr app](https://github.com/slyg/forecastr-app) and see how it can be re-implemented using elm


### Install and build locally

#### With Docker

```
$ docker-compose up
```

Build files are located in `/public`, you can serve them using `http-server`.


#### Without Docker

##### Prerequisites

- nodejs
- elm `v0.17`

_I may add a Dockerfile later on…_

##### Build

```bash
$ elm package install && ./build
```
Open `public/index.html`.
