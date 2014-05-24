stub-version := 0.3.0
STUBFILE := stub.make
extract = @perl -ne 's/^\s*// and print if $$rc = /^\[$(1)\]/.../^\[/ and $$rc !~ /(^1|E0)$$/' $(2)

# http://stackoverflow.com/a/8080887
MAKEFLAGS += $(if $(value VERBOSE),,--no-print-directory)
#  --silent --ignore-errors

# http://stackoverflow.com/a/21740114
.SILENT: help

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

stub-help:
	@echo This is stub, version $(stub-version)
	@echo
	@echo Usage:
	@echo ./stub COMMAND ARG=1 ARG=2
	@echo
	@echo available COMMANDs:
	@echo 'stub stub-help           # general help (this page)'
	@echo 'stub t-help T=template   # project specific help'

# t-help: required-variable-T
# 	@ $(MAKE) -C $(T) -f $(STUBFILE) help
# 	@ echo template targets:
# 	@ perl -ne 'print "$$1 ", $$3 ? "\t# $$3\n" : "\n" if /^(\w+):(.*?#(.*))?/' $(T)/$(STUBFILE)

FROM = $(T)
TEMPLATE = $(T)

ifdef TEMPLATE
include $(T)/$(STUBFILE)
endif

# t-%:
	# $(MAKE) -f $(T)/$(STUBFILE) $*