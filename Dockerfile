FROM ubuntu
RUN apt-get update
RUN apt-get install -y python
RUN echo 1.0 >> /etc/version && apt-get install -y git \
    && apt-get install -y iputils-ping
RUN mkdir /datos
WORKDIR /datos
RUN touch f1.txt
RUN mkdir /datos1
WORKDIR /datos1
RUN touch f2.txt

COPY index.html .
COPY app.log /datos

ADD docs docs
ADD f* /datos/
ADD f.tar .

ENV dir=/data dir1=/data1
RUN mkdir $dir && mkdir $dir1

#ARG dir2
#RUN mkdir $dir2

#ARG user
#ENV user_docker $user
#ADD add_user.sh /datos1
#RUN /datos1/add_user.sh

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get install -y apache2
EXPOSE 80
ADD entrypoint.sh /datos

ADD paginas /var/www/html
VOLUME ["/var/www/html"]


CMD /datos/entrypoint.sh

#ENTRYPOINT ["/bin/bash"]
