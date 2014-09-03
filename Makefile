
EXE = main.exe
MAINSRC  = src/type.opa src/todo.opa src/user.opa src/admin.opa src/main.opa src/ui.opa

OPAOPT = --parser js-like
PCKDIR = .
PCK  = sso.opx

HOST ?= $(strip $(shell cat .host))
ifeq "$(HOST)" ""
HOST=http://mail.opalang.org
endif
SSO_HOST ?= $(strip $(shell cat .sso_host))
ifeq "$(SSO_HOST)" ""
SSO_HOST=mail.opalang.org
endif
CONSUMER_KEY ?= $(strip $(shell cat .consumer_key))
ifeq "$(CONSUMER_KEY)" ""
CONSUMER_KEY="xxxxxxxxxxxxxxxx"
endif
CONSUMER_SECRET ?= $(strip $(shell cat .consumer_secret))
ifeq "$(CONSUMER_SECRET)" ""
CONSUMER_SECRET="xxxxxxxxxxxxxxxx"
endif

#DEBUG_OPT ?= --backtrace --display-logs --verbose 8
RUN_OPT ?= $(DEBUG_OPT) --db-remote:opado localhost:27017 --sso-host $(SSO_HOST) --host $(HOST) --consumer-key $(CONSUMER_KEY) --consumer-secret $(CONSUMER_SECRET)

all: exe

run: exe
	./$(EXE) $(RUN_OPT) || true ## prevent ugly make error 130 :) ##

clean::
	rm -f $(EXE)
	rm -rf _build

include Makefile.common
