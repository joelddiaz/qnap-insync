# Container to run on QNAP hardware to sync Google Drive to/from the QNAP
#
# Mount existing Google Drive contents (if you have it) to into the container
# before starting it. Set GDRIVE_PATH to wherever you mounted it into the
# container.
# Set INSYNC_AUTH to value returned from https://goo.gl/jv797S

FROM debian:latest

MAINTAINER <Joel>
LABEL version="0.0.1"
LABEL description="Container for running insync (https://insynchq.com/) on a QNAP device to sync your Google Drive"

RUN apt-get update && apt-get install -y wget && apt-get clean
RUN wget -qO - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key | apt-key add - && echo "deb http://apt.insynchq.com/debian jessie non-free contrib" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y insync-headless

ADD start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

ENV LANG en_US.UTF-8

CMD /usr/local/bin/start.sh
