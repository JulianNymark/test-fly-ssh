FROM ubuntu:24.04

# deps: ssh, nginx
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y openssh-server rsync

RUN sed -i 's/^#\s*Port.*/Port 2222/' /etc/ssh/sshd_config && \
    sed -i 's/^#\s*PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd
COPY authorized_keys /home/ubuntu/.ssh/authorized_keys

COPY docker_entrypoint.sh /
RUN chmod +x /docker_entrypoint.sh

EXPOSE 2222

ENTRYPOINT /docker_entrypoint.sh
