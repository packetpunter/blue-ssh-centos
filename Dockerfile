FROM blue-centos-base:latest
RUN yum -y install openssh-server
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
ADD ./config/sshd_config /etc/ssh/sshd_config
ADD ./config/sshd-banner /etc/ssh/sshd-banner
ADD ./id_rsa.pub /root
RUN mkdir -p ~/.ssh; touch ~/.ssh/authorized_keys; cat /root/id_rsa.pub > ~/.ssh/authorized_keys; chmod 644 ~/.ssh/authorized_keys
RUN yum -y install pwgen
RUN pwgen 255 1 | passwd --stdin root
RUN rm -rf /root/id_rsa.pub
WORKDIR /app/code
EXPOSE 22
ENTRYPOINT /usr/sbin/sshd -D
