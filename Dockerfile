#Flink Dockerfile
FROM centos:latest

ENV JAVA_8 java-1.8.0-openjdk-devel.x86_64 
ENV PACKAGES /usr/local/packages

#ENV_ZOOKEEPER
ENV ZOOKEEPER_LINK http://apache.mirror.cdnetworks.com/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz
ENV ZOOKEEPER_TAR zookeeper-3.4.10.tar.gz
ENV ZOOKEEPER_DIR zookeeper-3.4.10
ENV ZOOKEEPER_HOME ${PACKAGES}/zookeeper

#ENV_FLINK
ENV FLINK_LINK http://apache.mirror.cdnetworks.com/flink/flink-1.7.0/flink-1.7.0-bin-scala_2.12.tgz
ENV FLINK_TAR flink-1.7.0-bin-scala_2.12.tgz
ENV FLINK_DIR flink-1.7.0
ENV FLINK_HOME ${PACKAGES}/flink


# REDHAT : https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Linux.html
#ENV_SCALA
ENV SBT_LINK https://piccolo.link/sbt-1.2.7.tgz
ENV SBT_TAR sbt-1.2.7.tgz
ENV SBT_DIR sbt-1.2.7
ENV SBT_HOME ${PACKAGES}/sbt

#ENV_KAFKA
#ENV KAFKA_LINK http://apache.mirror.cdnetworks.com/kafka/2.0.0/kafka_2.11-2.0.0.tgz
#ENV KAFKA_TAR kafka_2.11-2.0.0.tgz
#ENV KAFKA_DIR kafka_2.11-2.0.0
#ENV KAFKA_HOME ${PACKAGES}/kafka

# PATH
#ENV PATH $KAFKA_HOME/bin:${ZOOKEEPER_HOME}/bin:$PATH
ENV PATH ${FLINK_HOME}/bin:${SBT_HOME}/bin:${ZOOKEEPER_HOME}/bin:$PATH
RUN echo "alias vi=vim" >> /etc/bashrc


RUN mkdir ${PACKAGES}

WORKDIR ${PACKAGES}
RUN yum update -y
RUN yum install vim wget ${JAVA_8} -y
RUN echo $'set hlsearch \n\
set nu  \n\
set autoindent \n\
set scrolloff=2 \n\
set wildmode=longest,list\n\
set ts=4\n\
set sts=4\n\ 
set sw=1\n\ 
set autowrite\n\ 
set autoread\n\ 
set cindent\n\ 
set bs=eol,start,indent\n\
set history=256\n\
set laststatus=2\n\ 
set paste\n\ 
set shiftwidth=4\n\ 
set showmatch\n\ 
set smartcase\n\ 
set smarttab\n\
set smartindent\n\
set softtabstop=4\n\
set tabstop=4\n\
set ruler\n\ 
set incsearch\n\
' > /root/.vimrc


# Zookeeper Install
RUN wget ${ZOOKEEPER_LINK}
RUN tar -xzvf ${ZOOKEEPER_TAR}
RUN ln -s ${ZOOKEEPER_DIR} zookeeper
RUN pwd
RUN mkdir /data
RUN touch /data/myid
RUN echo "==== PLZ setting myid File(/data/myid)"

# Flink Install
WORKDIR ${PACKAGES}
RUN wget ${FLINK_LINK}
RUN tar -xzvf ${FLINK_TAR}
RUN ln -s ${FLINK_DIR} flink

# SBT Install
WORKDIR ${PACKAGES}
RUN wget ${SBT_LINK}
RUN tar -xzvf ${SBT_TAR}
RUN ln -s ${SBT_DIR} sbt

# Kafka Install
#WORKDIR ${PACKAGES}
#RUN wget ${KAFKA_LINK}
#RUN tar -xzvf ${KAFKA_TAR}
#RUN ln -s ${KAFKA_DIR} kafka
#RUN mkdir /data1 /data2
