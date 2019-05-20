# 0.93.01
FROM homeassistant/qemux86-64-homeassistant:0.93.1

RUN apk add --no-cache ipmitool net-snmp-tools \
 && pip3 install mysqlclient pymysql
