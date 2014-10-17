SCRIPTS_DIR = ~/scripts/docker
BTS_DIR = openbts
SIP_DIR = sipserver

all: build_images

build_images: scripts build_bts build_sip

scripts:
	rm -rf ${BTS_DIR}/scripts ${SIP_DIR}/scripts
	cp -r ${SCRIPTS_DIR} ${BTS_DIR}/scripts
	cp -r ${SCRIPTS_DIR} ${SIP_DIR}/scripts

build_bts:
	sudo docker build -t openbts:init ${BTS_DIR}

build_sip:
	sudo docker build -t sipserver:init ${SIP_DIR}

base_image:
	sudo tar -C ~/trusty_base -c . | sudo docker import - trusty
