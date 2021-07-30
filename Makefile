# Makefile for H31 cellular service
SHELL := /bin/bash
SUDO := $(shell test $${EUID} -ne 0 && echo "sudo")
.EXPORT_ALL_VARIABLES:
PKGDEPS ?= modemmanager
SYSCFG=/etc/systemd
SW_LOCATION=sw_driver

.PHONY = clean dependencies install provision see uninstall 

default:
	@echo "Please choose an action:"
	@echo ""
	@echo "  dependencies: ensure all needed software is installed (requires internet)"
	@echo "  install: update programs and system scripts"
	@echo "  provision: interactively define the needed configurations (all of them)"
	@echo ""
	@echo "The above are issued in the order shown above.  dependencies is only done once."
	@echo ""

provision:
	@./provision.sh 

clean:
	@if [ -d src ] ; then cd src && make clean ; fi

dependencies:
	# NB: only needed when PKGDEPS is not empty
	@if [ ! -z "$(PKGDEPS)" ] ; then $(SUDO) apt-get install -y $(PKGDEPS) ; fi

disable:
	@$(SUDO) nmcli con down attcell ; $(SUDO) nmcli con delete "attcell"

install: dependencies

	@if [ -d "$(SW_LOCATION)" ] ; then echo "" && echo "Installing Sierra Wireless Driver..." && echo "" && cd $(SW_LOCATION) && make && make install ; fi		
	@$(MAKE) --no-print-directory -B provision
	
provision:	
	$(MAKE) --no-print-directory -B provision

see:
	$(SUDO) nmcli device show cdc-wdm0 | apn

uninstall:
	@$(MAKE) --no-print-directory disable
	@if [ -d "$(SW_LOCATION)" ] ; then $(SUDO) rm -r $(SW_LOCATION) ; fi
	


