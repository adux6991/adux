#https://www.v2ray.com/chapter_01/install.html
bash <(curl -L -s https://install.direct/go.sh)

#https://github.com/iMeiji/shadowsocks_install/wiki/shadowsocks-optimize
echo "\
# max open files
fs.file-max = 1024000
# max read buffer
net.core.rmem_max = 67108864
# max write buffer
net.core.wmem_max = 67108864
# default read buffer
net.core.rmem_default = 65536
# default write buffer
net.core.wmem_default = 65536
# max processor input queue
net.core.netdev_max_backlog = 4096
# max backlog
net.core.somaxconn = 4096

# resist SYN flood attacks
net.ipv4.tcp_syncookies = 1
# reuse timewait sockets when safe
net.ipv4.tcp_tw_reuse = 1
# turn off fast timewait sockets recycling
net.ipv4.tcp_tw_recycle = 0
# short FIN timeout
net.ipv4.tcp_fin_timeout = 30
# short keepalive time
net.ipv4.tcp_keepalive_time = 1200
# outbound port range
net.ipv4.ip_local_port_range = 10000 65000
# max SYN backlog
net.ipv4.tcp_max_syn_backlog = 4096
# max timewait sockets held by system simultaneously
net.ipv4.tcp_max_tw_buckets = 5000
# TCP receive buffer
net.ipv4.tcp_rmem = 4096 87380 67108864
# TCP write buffer
net.ipv4.tcp_wmem = 4096 65536 67108864
# turn on path MTU discovery
net.ipv4.tcp_mtu_probing = 1

# for high-latency network
net.ipv4.tcp_congestion_control = hybla
# forward ipv4
net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

echo "\
*               soft    nofile           512000
*               hard    nofile          1024000" >> /etc/security/limits.conf

echo "ulimit -SHn 1024000" >> /etc/profile

apt-get install python-m2crypto
apt-get install python-dev libevent-dev python-setuptools python-gevent
easy_install greenlet gevent

iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
sysctl -w net.ipv4.ip_forward=1
#iptables -I INPUT -p tcp --dport 443 -j ACCEPT
#iptables -I INPUT -p udp --dport 443 -j ACCEPT
service iptables restart

#https://teddysun.com/489.html
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
chmod +x bbr.sh
./bbr.sh