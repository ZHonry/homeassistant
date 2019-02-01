FROM homeassistant/home-assistant

RUN \
 sed -i 's@/deb.debian.org/@/mirrors.ustc.edu.cn/@g' /etc/apt/sources.list \
 && apt-get update \
 && apt-get -y install ipmitool snmp snmpd \
 && rm -rf /tmp/*
