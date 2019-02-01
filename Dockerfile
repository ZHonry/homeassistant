FROM homeassistant/home-assistant

RUN apt-get update \
 && apt-get -y install ipmitool snmp snmpd \
 && pip3 install tornado mysqlclient \
 && rm -rf /tmp/*
