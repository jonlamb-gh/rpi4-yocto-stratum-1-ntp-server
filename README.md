# RPi4 Stratum-1 NTP Server Image

Chrony stratum-1 time server using gpsd with pps.

TODO
* update these docs
* update iptables rules


## Hardware

* [Raspberry Pi 4](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)
* [Raspberry Pi 4 Ultra-Thin CNC Aluminum Alloy Passive Cooling Case](https://geekworm.com/products/raspberry-pi-4-ultra-thin-cnc-aluminum-alloy-metal-case-compatible-with-raspberry-pi-4-model-b-only)
* [5V 3A USB-C Power Supply](https://www.amazon.com/gp/product/B07X8C6PV6/ref=ppx_yo_dt_b_asin_title_o01_s00?ie=UTF8&psc=1)
* [GPS HAT](https://www.adafruit.com/product/2324)
* [CR1220 12mm Diameter - 3V Lithium Coin Cell Battery](https://www.adafruit.com/product/380)
* [GPS antenna](https://www.adafruit.com/product/960)
* [SMA to uFL/u.FL/IPX/IPEX RF Adapter Cable](https://www.adafruit.com/product/851)

## Config

TODO

## Build

Setup environment:

```bash
export IPTABLES_ICMP_ALLOW_IP_RANGE='a.b.c.d-a.b.c.e'
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE IPTABLES_ICMP_ALLOW_IP_RANGE"

export IPTABLES_SSH_ALLOW_CIDR='a.b.c.d/e'
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE IPTABLES_SSH_ALLOW_CIDR"

export IPTABLES_DNS_SERVER_IP='a.b.c.d'
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE IPTABLES_DNS_SERVER_IP"

export SSH_AUTH_KEYS_ME_USER='/path/to/authorized_keys'
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE SSH_AUTH_KEYS_ME_USER"
```

```bash
./setup

./build
```

## Deploy to SD Card

Find the image files:

```bash
bitbake -e rpilinux-image | grep ^DEPLOY_DIR_IMAGE
```

```bash
# dtb
cd /path/to/build/tmp/deploy/images/raspberrypi4-64/
cp bcm2711-rpi-4-b.dtb /media/card/BOOT/

# firmware
cd /path/to/build/tmp/deploy/images/raspberrypi4-64/bcm2711-bootfiles
cp -a ./* /media/card/BOOT/

# kernel
cp Image /media/card/BOOT/kernel_rpilinux.img

# rootfs
cd /media/card/ROOT/
sudo tar -xjf /path/tobuild/tmp/deploy/images/raspberrypi4-64/rpilinux-image-raspberrypi4-64.tar.bz2
```

## Initial Setup

* Change the `root` password, default is `root`
  ```bash
  passwd
  ```

## Useful Commands

```
chronyc sources

chronyc tracking

gpsmon time.home
```

## Links

* [OpenEmbedded Layer Index : zeus](https://layers.openembedded.org/layerindex/branch/zeus/recipes/)
* [Linux Hardening](https://madaidans-insecurities.github.io/guides/linux-hardening.html)
