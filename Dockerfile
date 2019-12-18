# ===============================================
# AWS CLI tools in a docker container
# ===============================================
FROM ubuntu:18.04
MAINTAINER Dale Anderson (http://www.acromedia.com/)

# ----------------
# Prevent a lot of complaining from apt
# ----------------
ENV DEBIAN_FRONTEND noninteractive

# ----------------
# Get everything up to date
# ----------------
RUN apt-get -qq update
RUN apt-get -yqq upgrade

# ----------------
# Prevent more complaining from apt
# ----------------
RUN apt-get install -yqq apt-utils
RUN apt-get install -yqq apt-transport-https

# ----------------
# Allow us to download and unpack things
# ----------------
RUN apt-get install -yqq curl
RUN apt-get install -yqq wget
RUN apt-get install -yqq unzip
RUN apt-get install -yqq bzip2
RUN apt-get install -yqq xz-utils

# ----------------
# Install EB CLI Pre Requisites
# ----------------
RUN apt-get install -yqq build-essential zlib1g-dev libssl-dev libncurses-dev libffi-dev libsqlite3-dev libreadline-dev libbz2-dev
RUN apt-get install -yqq git

# ----------------
# Install AWS Elastic Beanstalk CLI tools
# ----------------
RUN git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
RUN aws-elastic-beanstalk-cli-setup/scripts/bundled_installer
ENV PATH="/root/.ebcli-virtual-env/executables:${PATH}"
ENV PATH="/root/.pyenv/versions/3.7.2/bin:${PATH}"

# ----------------
# Install AWS Standard CLI tools, and add jq for easier processing of the all the json produced by awscli
# ----------------
RUN apt-get install -yqq awscli
RUN apt-get install -yqq jq

# ----------------
# Install Rsync for pushing/pulling files around
# ----------------
RUN apt-get install -yqq rsync

# ----------------
# Install Ansible + related tools
# ----------------
RUN apt-get update -yqq
RUN apt-get install -yqq software-properties-common
RUN apt-add-repository --yes --update ppa:ansible/ansible
RUN apt-get install -yqq ansible
RUN echo 'localhost' > /etc/ansible/hosts
RUN apt-get install -yqq sshpass openssh-client

# ----------------
# The eb command needs to run from inside the home dir
# ----------------
WORKDIR /root

# ----------------
# Set the default command: display versions of stuff we installed
# ----------------
COPY ./versions.sh /root/
RUN chmod +x /root/versions.sh
CMD ["/root/versions.sh"]
