SCRIPTS_DIR = container-scripts
ASTERISK_CONFIG_DIR = asterisk-config
BTS_DIR = openbts
SIP_DIR = sipserver

all: build_images

build_images: copy_files build_bts build_sip

copy_files: scripts asterisk-config

scripts:
	cd ${SCRIPTS_DIR}; \
		git archive --format tar -o ../scripts.tar master 
	rm -rf ${BTS_DIR}/scripts ${SIP_DIR}/scripts
	mkdir ${BTS_DIR}/scripts ${SIP_DIR}/scripts
	tar -C ${BTS_DIR}/scripts -xf scripts.tar
	tar -C ${SIP_DIR}/scripts -xf scripts.tar
	rm -f scripts.tar

asterisk-config:
	cd ${ASTERISK_CONFIG_DIR}; \
		git archive --format tar -o ../asterisk-config.tar master 
	rm -rf ${SIP_DIR}/asterisk-config
	mkdir ${SIP_DIR}/asterisk-config
	tar -C ${SIP_DIR}/asterisk-config -xf asterisk-config.tar
	rm -f asterisk-config.tar

build_bts:
	sudo docker build -t openbts:init ${BTS_DIR}

build_sip:
	sudo docker build -t sipserver:init ${SIP_DIR}

base_image:
	sudo tar -C ~/trusty_base -c . | sudo docker import - trusty

pull_submodules:
	git submodule foreach git pull

init_submodules:
	git submodule init
	git submodule update
