FROM homeassistant/qemux86-64-homeassistant:0.89.1

RUN apk add --no-cache ipmitool net-snmp-perl \
 && pip3 install tornado mysqlclient pymysql
