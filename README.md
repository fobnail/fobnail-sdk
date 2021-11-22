# fobnail-sdk

Dockerized fobnail software development kit

## Using container

Rust container is the newer version of SDK, to build it execute:

```shell
./build.sh
```

To build a sample Rust application execute:

```shell
$ git clone https://github.com/fobnail/nrf-hal
$ cd nrf-hal
$ git checkout blinky-demo-nrf52840
$ ./run-container.sh
(docker)$ cd examples/blinky-demo-nrf52840
(docker)$ cargo build --target=thumbv7em-none-eabihf
```
