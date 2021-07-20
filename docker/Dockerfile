FROM centos:7

ENV DEFAULT_REGION=${DEFAULT_REGION:-'eu-central-1'}
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY={AWS_SECRET_ACCESS_KEY}
ENV DEFAULT_OUTPUT=${DEFAULT_OUTPUT:-'json'}

RUN echo "Install unzip software" && \
    yum install unzip -y
RUN echo "Download and install AWS CLI" && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

COPY /include /
RUN echo "Setting up necessary permissions" && \
    chmod +x /etc/listObjectStore.sh
CMD ["/etc/listObjectStore.sh"]