FROM amazonlinux:2

# configure Node.js
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -

# install yum dependencies
RUN yum install -y rpm-build python-pip git jq nodejs

# install pip dependencies
RUN pip install awscli --upgrade
