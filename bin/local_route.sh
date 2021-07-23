nic_name=$(ip -o -4 route show to default|grep -v "ppp" | awk '{print $5}')
defGW=$(ip route list dev ${nic_name} | awk ' /^default/ {print $3}' | tail -1)
network=$(ip -o -f inet addr show dev enp12s0| awk '/scope global/{sub(/[^.]+\//,"0/",$4);print $4}\')
sudo ip route add 192.168.0.0/22 via ${defGW}
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
sudo ip route add 78.107.18.112/28 via ${defGW}

case "$network" in
    192.168.3.0/22) 
	gate="192.168.1.7"
		    ;;
    *)
	exit 1
esac

sudo ip route add 192.168.1.7/32 via $gate dev $nic_name
sudo ip route add 192.168.3.36/32 via $gate
sudo ip route add 192.168.2.212/32 via $gate
sudo ip route add 192.168.2.228/32 via $gate
sudo ip route add 192.168.4.0/24 via $gate
