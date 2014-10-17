FROM trusty
MAINTAINER Charlie Brown

RUN bash -c 'echo "deb http://files.ettus.com/binaries/uhd_stable/repo/uhd/ubuntu/`lsb_release -cs` `lsb_release -cs` main" > /etc/apt/sources.list.d/ettus.list'
RUN apt-get update && apt-get install --force-yes -y uhd

ADD debs/ /root/debs/
RUN dpkg -i /root/debs/downgrade/*.deb || apt-get -f install --force-yes -y
RUN dpkg -i /root/debs/openbts/liba53_0.1_amd64.deb || apt-get -f install --force-yes -y
RUN dpkg -i /root/debs/openbts/libcoredumper1_1.2.1-1_amd64.deb || apt-get -f install --force-yes -y
RUN dpkg -i /root/debs/openbts/libcoredumper-dev_1.2.1-1_amd64.deb || apt-get -f install --force-yes -y
RUN dpkg -i /root/debs/openbts/openbts_5.0_amd64.deb || apt-get -f install --force-yes -y
RUN rm -rf /root/debs/

RUN apt-get install --force-yes -y tmux psmisc make
ADD scripts/ /root/scripts/
RUN bash -c 'cd /root/scripts && make install'
RUN rm -rf /root/scripts/

RUN /home/openbts/openbtsconfig Control.LUR.OpenRegistration '.*'
#RUN /home/openbts/openbtsconfig TRX.Reference 1

CMD ["openbts_start"]
