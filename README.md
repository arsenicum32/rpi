# rpi
all settings for rpi 3w zero

downloads: 

wpa_supplicant.conf

```bash
country=GB
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="zibert"
    psk="Vasilisa09"
}
```
interfaces
```bash
source-directory /etc/network/interfaces.d

auto lo
auto eth0
auto wlan0
auto uap0

iface eth0 inet dhcp
iface lo inet loopback

allow-hotplug wlan0

iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

iface uap0 inet static
  address 192.168.50.1
  netmask 255.255.255.0
  network 192.168.50.0
  broadcast 192.168.50.255
  gateway 192.168.50.1
```
hostapd.conf
```bash
interface=uap0
ssid=testPiAP
hw_mode=g
channel=11
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=badpassword
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
```
hostapdstart
```bash
#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
iw dev wlan0 interface add uap0 type __ap
service dnsmasq restart
sysctl net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -s 192.168.50.0/24 ! -d 192.168.50.0/24 -j MASQUERADE
ifup uap0
hostapd /etc/hostapd/hostapd.conf
```
dnsmasq.conf
```bash
interface=lo,uap0
no-dhcp-interface=lo,wlan0
bind-interfaces
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=192.168.50.50,192.168.50.150,12h
```

