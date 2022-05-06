# https://circleci.com/developer/images/image/cimg/python
FROM cimg/python:2.7.18-node

ARG GCLOUD_VERSION=359.0.0

# Set working directory while setting up system
WORKDIR /home/circleci

# Update system
RUN sudo apt update
RUN sudo apt install -y default-libmysqlclient-dev
RUN sudo apt install default-mysql-client
RUN sudo wget https://raw.githubusercontent.com/paulfitz/mysql-connector-c/master/include/my_config.h -O /usr/include/mysql/my_config.h

# Gcloud: Install
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
RUN tar -xf google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
RUN CLOUDSDK_CORE_DISABLE_PROMPTS=1 ./google-cloud-sdk/install.sh

# GCloud: Update path
RUN echo "source ./google-cloud-sdk/path.bash.inc" >> /home/circleci/.bashrc
RUN echo "source ./google-cloud-sdk/completion.bash.inc" >> /home/circleci/.bashrc
ENV PATH="$PATH:/home/circleci/google-cloud-sdk/bin"

# GCloud: Install components
RUN CLOUDSDK_CORE_DISABLE_PROMPTS=1 gcloud components install app-engine-python
RUN CLOUDSDK_CORE_DISABLE_PROMPTS=1 gcloud components install app-engine-python-extras
RUN CLOUDSDK_CORE_DISABLE_PROMPTS=1 gcloud components update --version=359.0.0

# GCloud: Postinstall Fix (for pyenv & pip)
RUN rm -rf /home/circleci/.pyenv
RUN curl https://pyenv.run | bash
RUN sudo apt install python-pip

# Set working directory back
WORKDIR /home/circleci/project
