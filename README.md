# kozos for H8 3069F

kozos is Operating system to run on H8 3069F

reference: [12ステップで作る組み込みOS自作入門](http://kozos.jp/books/makeos/)

## Documents

[Click here for documents](doc/README.md)

## Setup

```sh
# ubuntu 18.04
git clone https://github.com/basd4g/kozos.git
cd kozos

sudo apt update
sudo apt install gcc cu lrzsz
make
```

[Click here for details](doc/setup.md)

## Run

### Write boot loader

1. Set dip switch

ON-ON-OFF-ON

(Writing EEPROM mode)

2. Connect H8 3069F with host PC

3. Define device path

If h8 3069f is connected as `/dev/ttyUSB0`,

```bootload/Makefile
H8WRITE_SERDEV = /dev/ttyUSB0
```

4. Build & Write

```sh
# Build
$ cd bootload
$ make

# Write
$ sudo make image
```

### Boot from boot loader

5. Set dip switch

ON-OFF-ON-OFF

(Boot from EEPROM mode)

6. Reboot

Push reset switch.

H8 3069F boot from boot loader in EEPROM.

7. send OS

```sh
$ sudo chmod o+rwx /dev/ttyUSB0
$ sudo make send
```

8. check sended data

```
$ sudo chmod o+rwx /dev/ttyUSB0
$ sudo cu -l /dev/ttyUSB0 -s 9600
dump

$ od --format=x1 defines.h
```

