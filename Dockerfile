# 0.92.2
FROM homeassistant/qemux86-64-homeassistant:0.92.2

RUN apk add --no-cache ipmitool net-snmp-tools \
 && pip3 install mysqlclient pymysql
