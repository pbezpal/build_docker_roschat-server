#Загрузка базового образа Centos с настройками для systemd
FROM hippolab/centos:systemd

LABEL version="1.0"
LABEL maintainer="bezpalko@infotek.ru"

COPY ./CentOS-ORMP.repo /etc/yum.repos.d/
COPY ./license/ /opt/
COPY ./start_ansible_playbook.sh /opt/
COPY ./start_services.sh /opt/
COPY ./server_playbook.yml /opt/
COPY ./rpms/ /tmp/

RUN yum -y install ansible \
  turnserver \
  sudo \
  cryptopp \
  cyrus-sasl-plain \
  nodejs \
  mutt \
  mc \
  net-tools \
  openssh-server \
  openssh-clients && \
  yum clean all

RUN echo "[server]" >> /etc/ansible/hosts && \
    echo "ansible_password=Art7Tykx78Dp" >> /etc/ansible/hosts && \
    chmod +x /tmp/start_ansible_playbook.sh && \
    echo "root:Art7Tykx78Dp" | chpasswd

WORKDIR /

EXPOSE 8080 8081 80 443 161 5060 3478 1110 22 49000-49150 49152-49182
