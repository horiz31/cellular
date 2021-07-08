# Automation boilerplate

SHELL := /bin/bash
SN := $(shell hostname)
SUDO := $(shell test $${EUID} -ne 0 && echo "sudo")
.EXPORT_ALL_VARIABLES:

LOCAL=/usr/local
LOCAL_SCRIPTS=cellular-start.sh
CONFIG ?= /var/local
LIBSYSTEMD=/lib/systemd/system
PKGDEPS ?= libqmi-utils udhcpc
SERVICES=cellular.service
KILLSERVICES=dhcpcd5
KILLPKGS=modemmanager
SYSCFG=/etc/systemd
SW_LOCATION=sw_driver

.PHONY = clean dependencies enable install provision see uninstall 

default:
	@echo "Please choose an action:"
	@echo ""
	@echo "  dependencies: ensure all needed software is installed (requires internet)"
	@echo "  install: update programs and system scripts"
	@echo "  provision: interactively define the needed configurations (all of them)"
	@echo ""
	@echo "The above are issued in the order shown above.  dependencies is only done once."
	@echo ""

$(SYSCFG)/cellular.conf:
	PLATFORM=$(PLATFORM) ./provision.sh $@ $(DRY_RUN)

clean:
	@if [ -d src ] ; then cd src && make clean ; fi

dependencies:
	# NB: only needed when PKGDEPS is not empty
	@if [ ! -z "$(PKGDEPS)" ] ; then $(SUDO) apt-get install -y $(PKGDEPS) ; fi

disable:
	@( for c in stop disable ; do $(SUDO) systemctl $${c} $(SERVICES) ; done ; true )

enable:
	@( for c in stop disable ; do $(SUDO) systemctl $${c} $(SERVICES) ; done ; true )
	@( for s in $(SERVICES) ; do $(SUDO) install -Dm644 $${s%.*}.service $(LIBSYSTEMD)/$${s%.*}.service ; done ; true )
	@if [ ! -z "$(SERVICES)" ] ; then $(SUDO) systemctl daemon-reload ; fi
	@( for s in $(SERVICES) ; do $(SUDO) systemctl enable $${s%.*} ; done ; true )
	@echo ""
	@echo "Install complete, please reboot now..."	 
	@echo ""

install: dependencies
	@for s in $(LOCAL_SCRIPTS) ; do $(SUDO) install -Dm755 $${s} $(LOCAL)/bin/$${s} ; done
    	# NB: stop conflicting services
	@( for c in stop disable ; do $(SUDO) systemctl $${c} $(KILLSERVICES) ; done ; true )
	# NB: remove conflicting packages
	@if [ ! -z "$(KILLPKGS)" ] ; then $(SUDO) apt-get purge -y $(KILLPKGS) ; fi	
	@if [ -d "$(SW_LOCATION)" ] ; then cd $(SW_LOCATION) && make && make install ; fi
	@${SUDO} usermod -a -G root $$USER 
	@$(MAKE) --no-print-directory -B $(SYSCFG)/cellular.conf $(DRY_RUN)
	@$(MAKE) --no-print-directory enable
	
provision:	
	$(MAKE) --no-print-directory -B $(SYSCFG)/cellular.conf $(DRY_RUN)	
	$(SUDO) systemctl restart cellular

see:
	$(SUDO) cat $(SYSCFG)/cellular.conf

uninstall:
	@$(MAKE) --no-print-directory disable
	@( for s in $(SERVICES) ; do $(SUDO) rm $(LIBSYSTEMD)/$${s%.*}.service ; done ; true )
	@if [ ! -z "$(SERVICES)" ] ; then $(SUDO) systemctl daemon-reload ; fi
	$(SUDO) rm -f $(SYSCFG)/cellular.conf


