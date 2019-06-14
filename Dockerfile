# 0.94.3
FROM homeassistant/qemux86-64-homeassistant:0.94.3

RUN apk add --no-cache default-libmysqlclient-dev libssl-dev ipmitool net-snmp-tools \
 && pip3 install mysqlclient pykonkeio

