#!/bin/sh
# open bbr
# echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
# echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p


chmod 755 /usr/local/bin/jussskkya


install -d /usr/local/etc/jussskkya
cat << EOF > /usr/local/etc/jussskkya/config.json
{
  "log": {
    "loglevel": "debug"
  },
  "inbounds": [
    {
      "port": "$PORT",
      "protocol": "VLESS",
      "settings": {
        "clients": [
          {
            "id": "51b37a8f-d0f0-4f18-91cc-4b0298e1f221",
            "alterId": 0
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF


/usr/local/bin/jussskkya -config /usr/local/etc/jussskkya/config.json
