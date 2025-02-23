FROM ubuntu:18.04

#-------------------------------------------------------------------------------
# Environment

# Temporary mount point for bind mounts.
ENV TMP_MNT=/tmp/mnt

# Use user ubuntu
ENV GUEST_USER=ubuntu
ENV GUEST_HOME=/home/${GUEST_USER}
ENV UID_GID=1000

# Locale settings
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

ENV TERM=xterm-256color

#-------------------------------------------------------------------------------
# Prerequisites
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install xterm
#RUN apt-get -y install libpulse0
RUN apt-get -y install command-not-found
RUN apt-get -y install wget
RUN apt-get -y install bzip2

# A timezone needs to be set before tzdata is installed.
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
RUN apt-get -y install locales
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN /usr/sbin/locale-gen

RUN apt-get -y install sudo

# Eagle dependencies.
#
# Older Eagle versions (e.g. 6.6.0) are 32-bit applications.
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386

# Install particular eagle dependencies
RUN apt-get -y install libnspr4:i386 libglib2.0-0:i386 libnss3:i386
#RUN apt-get -y install libasound2:i386
RUN apt-get -y install libcups2:i386
RUN apt-get -y install man-db:i386

# Got these with ldd eagle-6.6.0/bin/eagle
RUN apt-get -y install libxrender1:i386
RUN apt-get -y install libxrandr2:i386
RUN apt-get -y install libfreetype6:i386
RUN apt-get -y install libfontconfig1:i386
RUN apt-get -y install libxi6:i386
RUN apt-get -y install zlib1g:i386
# This one was tricky to find.
RUN apt-get install -y --no-install-recommends libssl1.0.0:i386
RUN apt-get -y install libxcursor1:i386

#-------------------------------------------------------------------------------
# Install Eagle
ARG EAGLE_VERSION
ARG EAGLE_RUN_FILE

ENV EAGLE_DIR=eagle-${EAGLE_VERSION}

# Create the user
RUN groupadd -g ${UID_GID} ${GUEST_USER}
RUN useradd -d ${GUEST_HOME} -s /bin/bash -m ${GUEST_USER} -u ${UID_GID} -g ${UID_GID}
RUN chown -hR ${GUEST_USER}:${GUEST_USER} ${GUEST_HOME}

# Go to the user's home directory.
WORKDIR ${GUEST_HOME}

# Install Eagle from the "run" file.
COPY ${EAGLE_RUN_FILE} .
RUN ./${EAGLE_RUN_FILE} .
RUN rm ${EAGLE_RUN_FILE}

# Fix ownership.
RUN chown -hR ${GUEST_USER}:${GUEST_USER} ${GUEST_HOME}/${EAGLE_DIR}

USER ${GUEST_USER}
ENV HOME=${GUEST_HOME}
SHELL ["/bin/bash", "-c"]
CMD ${HOME}/${EAGLE_DIR}/bin/eagle
