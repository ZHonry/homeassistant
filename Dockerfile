# 0.91.0
FROM homeassistant/qemux86-64-homeassistant:0.91.0

RUN apk add --no-cache ipmitool net-snmp-tools \
 && pip3 install tornado mysqlclient pymysql

