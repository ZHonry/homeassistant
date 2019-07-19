# 0.96.1
FROM homeassistant/qemux86-64-homeassistant:0.96.1

RUN apk add --no-cache ipmitool net-snmp-tools \
&& pip3 install mysqlclient pymysql pykonkeio pyunifi==2.16

# Cleanup.
RUN rm -rf /var/cache/apk/* /tmp/*

