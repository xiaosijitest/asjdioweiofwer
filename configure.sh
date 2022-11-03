#!/bin/sh
# open bbr
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

# Download and install xray
mkdir /tmp/xray
curl -L -H "Cache-Control: no-cache" -o /tmp/xray/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
rm -rf /tmp/xray/xray.zip
unzip /tmp/xray/xray.zip -d /tmp/xray
install -m 755 /tmp/xray/xray /usr/local/bin/jussskkya

# Remove temporary directory
rm -rf /tmp/xray

# xray new configuration
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
            "id": "$UUID",
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

# Run xray
/usr/local/bin/jussskkya -config /usr/local/etc/jussskkya/config.json
