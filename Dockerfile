# Container to run on QNAP hardware to sync Google Drive to/from the QNAP
#
# Mount existing Google Drive contents (if you have it) to into the container
# before starting it. Set GDRIVE_PATH to wherever you mounted it into the
# container.
# Set INSYNC_AUTH to value returned from https://goo.gl/jv797S

FROM debian:latest

MAINTAINER <Joel>
LABEL description="Container for running insync (https://insynchq.com/) on a QNAP device to sync your Google Drive"

RUN apt-get update && apt-get install -y gnupg2 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C && \
    echo "deb http://apt.insynchq.com/debian stretch non-free contrib" > /etc/apt/sources.list.d/insync.list && \
    apt-get update && apt-get install -y insync-headless && apt-get clean

ADD start.sh /usr/local/bin/

ENV LANG en_US.UTF-8

CMD /usr/local/bin/start.sh
