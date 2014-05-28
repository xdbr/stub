default: help

help:
	@echo barbaz

component: required-variable-TO controller directive factory filter service view
controller: required-variable-TO required-variable-name make-directory-$(TO)
	cp $(FROM)/controller.coffee $(TO)/$(name).coffee						# rename
	perl -i -pe 's{{{name}}}{$(name)}g' $(TO)/$(name).coffee		# replace

# mkdir -p $(TO)
ng-%: required-variable-TO required-variable-name
	mkdir -p $(TO)
	cp $(FROM)/$*.coffee $(TO)/$(name)-$*.coffee
	perl -i -pe 's{{{name}}}{$(name)}g' $(TO)/$(name)-$*.coffee

directive: ng-directive
factory: ng-factory
filter: ng-filter
service: ng-service
view: required-variable-TO required-variable-name make-directory-$(TO)
	cp $(FROM)/controller.coffee $(TO)/$(name).jade
	perl -i -pe 's{{{name}}}{$(name)}g' $(TO)/$(name).jade