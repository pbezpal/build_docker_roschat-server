#Загрузка базового образа Centos с настройками для systemd
FROM centos:centos7.8.2003

LABEL version="1.0"
LABEL maintainer="bezpalko@infotek.ru"

ENV container=docker

COPY container.target /etc/systemd/system/container.target

RUN ln -sf /etc/systemd/system/container.target /etc/systemd/system/default.target

ENTRYPOINT ["/sbin/init"]

CMD ["--log-level=info"]

STOPSIGNAL SIGRTMIN+3

COPY ./license/ /opt/license/
COPY ./start_ansible_playbook.sh /opt/
COPY ./start_services.sh /opt/
COPY ./server_playbook.yml /opt/
COPY ./rpms/ /opt/rpms/

RUN yum -y install epel-release
RUN yum -y install ansible && yum clean all

COPY ./CentOS-ORMP.repo /etc/yum.repos.d/

RUN mkdir -p /etc/ansible && \
    echo "[server]" > /etc/ansible/hosts && \
    echo "ansible_password=Art7Tykx78Dp" >> /etc/ansible/hosts && \
    chmod +x /opt/start_ansible_playbook.sh && \
    echo "root:Art7Tykx78Dp" | chpasswd

WORKDIR /

EXPOSE 8080 8088 8081 80 88 443 446 161 5060 3478 1110 22 49000-49150 49152-49182
