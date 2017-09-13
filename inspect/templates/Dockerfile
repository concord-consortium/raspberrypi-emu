FROM ubuntu:14.04

ENV     APP_HOME /dataflow
RUN     mkdir $APP_HOME
WORKDIR $APP_HOME
ADD     ./rhizo-server          $APP_HOME/rhizo-server
ADD     ./docker-entrypoint.sh  $APP_HOME/rhizo-server

RUN     sudo apt-get update
RUN     sudo apt-get install -y python-setuptools python-dev build-essential python-pip libffi-dev libssl-dev libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

#
# Install rhizo-server requirements
#
WORKDIR $APP_HOME/rhizo-server
RUN     sudo pip install -r requirements.txt

#
# Create dirs for named volumes
#
RUN     mkdir $APP_HOME/rhizo-server/settings
RUN     mkdir -p /var/lib/sqlite

EXPOSE  5000

CMD     ./docker-entrypoint.sh

