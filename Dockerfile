FROM homeassistant/qemux86-64-homeassistant:0.90.0

RUN apk add --no-cache ipmitool net-snmp-tools \
 && pip3 install tornado mysqlclient pymysql
