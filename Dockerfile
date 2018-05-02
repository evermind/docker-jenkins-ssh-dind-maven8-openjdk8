FROM jenkins/ssh-slave

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg2 && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker-ce.list && \
    apt-get update && apt-get -y dist-upgrade && apt-get install -y maven docker-ce && \
    usermod -a -G docker jenkins

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
