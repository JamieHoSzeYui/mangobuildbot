# We're using debian 69
FROM debian:buster-slim

#
# We have to uncomment Community repo for some packages
#
RUN sed -e 's;^#http\(.*\)/edge/community;http\1/edge/community;g' -i /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

#
# Installing Packages
#
RUN apt-get update && apt-get install --assume-yes --no-install-recommends bc build-essential zip curl libstdc++6 git wget python gcc clang libssl-dev repo rsync flex bison ccache

RUN python3 -m ensurepip \
    && pip3 install --upgrade pip setuptools \
    && pip3 install wheel \
    && rm -r /usr/lib/python*/ensurepip && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

#
# Clone repo and prepare working directory
#
RUN git clone https://github.com/JamieHoSzeYui/mango414 /mango414
RUN cd /mango414
RUN wget <https://raw.githubusercontent.com/JamieHoSzeYui/mangobuildrrrr/master/build.sh>
RUN chmod 0777 /mango414
WORKDIR /root/mango414/

#
# Install requirements
#
CMD ["bash","build.sh"]
