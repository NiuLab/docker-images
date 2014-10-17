FROM trusty
MAINTAINER Charlie Brown

RUN apt-get update

ADD debs/ /root/debs/
ADD asterisk/ /root/asterisk/
RUN dpkg -i /root/debs/downgrade/*.deb || apt-get -f install --force-yes -y
RUN dpkg -i /root/debs/openbts/liba53_0.1_amd64.deb || apt-get -f install --force-yes -y
RUN dpkg -i /root/debs/openbts/libcoredumper1_1.2.1-1_amd64.deb || apt-get -f install --force-yes -y
RUN dpkg -i /root/debs/openbts/libcoredumper-dev_1.2.1-1_amd64.deb || apt-get -f install --force-yes -y
RUN dpkg -i /root/debs/openbts/sipauthserve_5.0_amd64.deb || apt-get -f install --force-yes -y
RUN dpkg -i /root/debs/openbts/smqueue_5.0_amd64.deb || apt-get -f install --force-yes -y
RUN dpkg -i /root/debs/openbts/range-asterisk_11.7.0.4_amd64.deb || apt-get -f install --force-yes -y
RUN dpkg -i --force-confdef /root/debs/openbts/range-asterisk-config_5.0_all.deb || apt-get -f install -o Dpkg::Options::="--force-confdef" --force-yes -y
RUN cp /root/asterisk/* /etc/asterisk

RUN apt-get install --force-yes -y tmux psmisc make
ADD scripts/ /root/scripts/
RUN bash -c 'cd /root/scripts && make install'
RUN rm -rf /root/scripts/
RUN chown -R asterisk:www-data /var/lib/asterisk/sqlite3dir

ADD etc/OpenBTS.conf /etc/rsyslog.d/
ADD bin/smqueueconfig /home/openbts/

CMD ["sipserver_start"]
