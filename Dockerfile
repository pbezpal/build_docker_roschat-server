#Загрузка базового образа Centos с настройками для systemd
FROM hippolab/centos:systemd

LABEL version="1.0"
LABEL maintainer="bezpalko@infotek.ru"

COPY ./CentOS-ORMP.repo /etc/yum.repos.d/
COPY ./license/ /opt/roschat-server/certificates/https/
COPY ./start_ansible_playbook.sh /tmp/
COPY ./start_services.sh /tmp/
COPY ./server_playbook.yml /tmp/
COPY ./rpms/ /tmp/

RUN yum -y install ansible \
  turnserver \
  cryptopp \
  cyrus-sasl-plain \
  nodejs \
  mutt \
  mc \
  net-tools \
  freetype \
  fribidi \
  fontconfig \
  openssh-server && \
  yum clean all

RUN echo "[server]" >> /etc/ansible/hosts && \
    echo "ansible_password=123456" >> /etc/ansible/hosts && \
    chmod +x /tmp/start_ansible_playbook.sh && \
    echo "root:123456" | chpasswd

WORKDIR /

EXPOSE 8080 8081 80 443 5060 3478 1110 22 49000-49150 49152-49182
