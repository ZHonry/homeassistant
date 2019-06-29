# 0.95.4
FROM homeassistant/qemux86-64-homeassistant:0.95.4

RUN apk add --no-cache ipmitool net-snmp-tools \
&& pip3 install mysqlclient pymysql pykonkeio
