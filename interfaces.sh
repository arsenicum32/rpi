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
