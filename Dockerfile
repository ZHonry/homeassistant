# 0.91.3
FROM homeassistant/qemux86-64-homeassistant:0.91.3

RUN apk add --no-cache ipmitool net-snmp-tools \
 && pip3 install mysqlclient pymysql
