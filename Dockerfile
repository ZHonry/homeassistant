FROM homeassistant/qemux86-64-homeassistant:0.89.2

RUN apk add --no-cache ipmitool net-snmp-tools \
 && pip3 install tornado mysqlclient pymysql
