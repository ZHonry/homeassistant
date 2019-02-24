FROM homeassistant/intel-nuc-homeassistant:0.88.0

RUN apt-get update \
 && apt-get -y install ipmitool snmp snmpd python3-dev libssl-dev libffi-dev mjpegtools \
 && pip3 install tornado mysqlclient pymysql \
 && rm -rf /tmp/* \
 && rm -rf /var/lib/apt/lists/*
