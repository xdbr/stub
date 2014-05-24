stub-version := 0.3.0
STUBFILE := stub.make
STUB_HOME := ~/.stubz
# extract = @perl -ne 's/^\s*// and print if $$rc = /^\[$(1)\]/.../^\[/ and $$rc !~ /(^1|E0)$$/' $(2)
# 'fqrn' is full-qualified repo name
parse-repo-fqrn = $(shell perl -e '$$_=shift @ARGV; s{https?://}{};           print' $(1))
parse-repo-user = $(shell perl -e '$$_=shift @ARGV; s{https?://(.*)/.*}{$$1}; print' $(1))
parse-repo-name = $(shell perl -e '$$_=shift;s{https?://.*/(.*)}{$$1};			  print' $(1))

fqrn = $(call parse-repo-fqrn,$(from))
user = $(call parse-repo-user,$(from))
repo = $(call parse-repo-name,$(from))
dest = $(STUB_HOME)/templates/$(user)

# http://stackoverflow.com/a/8080887
MAKEFLAGS += $(if $(value VERBOSE),,--no-print-directory)
#  --silent --ignore-errors

# http://stackoverflow.com/a/21740114
$(VERBOSE).SILENT: help

default: stub-help

# Excellent help here:
# http://stackoverflow.com/questions/4728810/makefile-variable-as-prerequisite
required-variable-%:
	@if [ "${${*}}" == "" ]; then \
		echo ;\
	 	echo "stub: error: Variable \`$*' not set"; \
	 	exit 1; \
	fi

optional-variable-%:
	@if [ "${${*}}" == "" ]; then \
		echo ;\
	 	echo "stub: warning: Optional variable \`$*' not set"; \
		while true; do \
				echo "Continue? [yn]" ; \
		    read yn; \
		    case $$yn in \
		        [Yy]* ) break ;; \
		        [Nn]* ) exit 2;; \
		        * ) echo "Please answer yes or no.";; \
		    esac; \
		done; \
	fi

variable-%:
	@if [ "${${*}}" == "" ]; then \
		echo Variables: ;\
	 	echo "\`$*'"; \
	fi

stub-help: stub-description stub-usage stub-targets

stub-description:
	@echo This is stub, version $(stub-version)
	@echo

stub-usage:
	@echo Usage:
	@echo "  stub COMMAND ARG=1 ARG=2 ..."
	@echo
	@echo Available COMMANDs:
	@echo

stub-targets: stub-target-completion stub-target-install stub-target-installed stub-target-uninstall stub-target-show stub-target-show-commands stub-target-info stub-target-update stub-target-upgrade stub-target-update-all
stub-target-completion: 		; @echo "  completion     -- give bash completion to include in ~/.bashrc (N/A yet)"
stub-target-install: 				; @echo "  install        -- install a template locally"
stub-target-installed: 			; @echo "  installed      -- show locally installed templates"
stub-target-uninstall: 			; @echo "  uninstall      -- uninstall local template"
stub-target-show: 					; @echo "  show           -- show a template's stubfile"
stub-target-show-commands: 	; @echo "  show-commands  -- show only commands of a template's stubfile'"
stub-target-info: 					; @echo "  info           -- info about a template"
stub-target-update: 				; @echo "  update         -- update lcoally installed template"
stub-target-update-all: 		; @echo "  update-all     -- update all locally installed templates"
stub-target-upgrade: 				; @echo "  upgrade        -- upgrade stub itself"

completion:
	@echo shell completion


thismakefile: thismake := $(lastword $(MAKEFILE_LIST))
thismakefile: ;@echo this makefile is $(thismake)

install: required-variable-from
	@ mkdir -p $(STUB_HOME)/templates/$(user); \
	  [[ ! -e $(dest)/$(repo) ]] && git clone $(from) $(dest)/$(repo) \
   	&& echo $(user)/$(repo) >> $(STUB_HOME)/.installed \
	  && sort -uo $(STUB_HOME)/.installed $(STUB_HOME)/.installed \
	  || echo Already installed -- you might want to update though?

uninstall: required-variable-from
	@ rm -rf $(dest)/$(repo) && \
	  cat $(STUB_HOME)/.installed | \
		grep -v $(user)/$(repo) > $(STUB_HOME)/.installed
installed:
	@ cat $(STUB_HOME)/.installed

show: required-variable-template
	@ cat $(template)/stub.make

show-commands: required-variable-template
	@cat $(template)/stub.make | perl -ne 's/^\t(?=\w)// and print'

info:
	@echo show info of project.make

tree:

update: required-variable-from
	@echo updating template FOO
	@cd $(dest)/$(repo) && git pull

update-all:
	@echo updating all templates

upgrade:
	@echo upgrading stub
# t-help: required-variable-T
# 	@ $(MAKE) -C $(T) -f $(STUBFILE) help
# 	@ echo template targets:
# 	@ perl -ne 'print "$$1 ", $$3 ? "\t# $$3\n" : "\n" if /^(\w+):(.*?#(.*))?/' $(T)/$(STUBFILE)

FROM = $(T)
TEMPLATE := $(T)

ifdef TEMPLATE
include $(T)/$(STUBFILE)
endif

# t-%:
	# $(MAKE) -f $(T)/$(STUBFILE) $*