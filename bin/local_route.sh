defGW=$(ip route list dev enp3s0 | awk ' /^default/ {print $3}' | tail -1)
sudo ip route add 192.168.0.0/22 via ${defGW}
sudo ip route add 192.168.1.7/32 via 192.168.20.8 dev enp3s0
sudo ip route add 192.168.3.36/32 via 192.168.20.8
sudo ip route add 192.168.2.212/32 via 192.168.20.8
sudo ip route add 192.168.2.228/32 via 192.168.20.8
sudo ip route add 192.168.4.0/24 via 192.168.20.3
sudo ip route add 192.168.30.0/24 via ${defGW}
sudo ip route add 192.168.40.0/24 via ${defGW}
sudo ip route add 10.254.2.0/30 via ${defGW}
sudo ip route add 194.247.190.66 via ${defGW}
sudo ip route add 194.85.88.0/24 via ${defGW}
sudo ip route add 212.46.229.20/30 via ${defGW}
sudo ip route add 217.69.139.160 via ${defGW}
sudo ip route add 94.100.180.16 via ${defGW}
sudo ip route add 91.189.116.42 via ${defGW}
sudo ip route add 91.189.116.40 via ${defGW}
sudo ip route add 91.189.116.43 via ${defGW}
sudo ip route add 91.189.116.41 via ${defGW}
sudo ip route add 195.239.45.194 via ${defGW}
