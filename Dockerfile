#Загрузка базового образа Centos с настройками для systemd
FROM hippolab/centos:systemd

LABEL version="1.0"
LABEL maintainer="bezpalko@infotek.ru"

COPY ./CentOS-ORMP.repo /etc/yum.repos.d/
COPY ./license/ /opt/license/
COPY ./start_ansible_playbook.sh /opt/
COPY ./start_services.sh /opt/
COPY ./server_playbook.yml /opt/
COPY ./rpms/ /tmp/

RUN yum -y install python-yaml \
  python-jinja2 \
  git \
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

RUN git clone http://github.com/ansible/ansible.git /tmp/ansible

WORKDIR /tmp/ansible

ENV PATH /tmp/ansible/bin:/sbin:/usr/sbin:/usr/bin

ENV ANSIBLE_LIBRARY /tmp/ansible/library

ENV PYTHONPATH /tmp/ansible/lib:$PYTHON_PATH

RUN mkdir -p /etc/ansible && \
    echo "[server]" > /etc/ansible/hosts && \
    echo "ansible_password=Art7Tykx78Dp" >> /etc/ansible/hosts && \
    chmod +x /opt/start_ansible_playbook.sh && \
    echo "root:Art7Tykx78Dp" | chpasswd

WORKDIR /

EXPOSE 8080 8088 8081 80 88 443 446 161 5060 3478 1110 22 49000-49150 49152-49182
