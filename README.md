# fobnail-sdk

Dockerized fobnail software development kit

## Build

```shell
$ ./build.sh
```

## Install

`run-fobnail-sdk.sh` script can be used to invoke commands within the
`fobnail-sdk` container. Place it in the PATH for convenience. For example:

```shell
$ ln -s $(readlink -f ./run-fobnail-sdk.sh) ~/bin/run-fobnail-sdk.sh
```

# Run

* Enter interactive shell:

```shell
$ run-fobnail-sdk.sh
```

* Execute some command (e.g. `cargo --version`)

```shell
$ run-fobnail-sdk.sh cargo --version

$ run-fobnail-sdk.sh cargo  build
```
