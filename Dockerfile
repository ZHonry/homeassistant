# 0.94.4
FROM homeassistant/qemux86-64-homeassistant:0.94.4

RUN apk add --no-cache default-lib mysqlclient-dev libssl-dev ipmitool net-snmp-tools \
 && pip3 install mysqlclient pykonkeio
