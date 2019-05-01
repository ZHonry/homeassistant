# 0.92.1
FROM homeassistant/qemux86-64-homeassistant:0.92.1

RUN apk add --no-cache ipmitool net-snmp-tools \
 && pip3 install mysqlclient pymysql
