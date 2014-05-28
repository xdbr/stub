version = 0.1.0
view ?= jade
code ?= coffee

default: help

help:
	@echo stub template for angular components v$(version)

component: ng-controller ng-directive ng-factory ng-filter ng-service ng-view

ng-view: type:=view
ng-controller ng-directive ng-factory ng-filter ng-service: type:=code

ng-%: required-variable-TO required-variable-name optional-variable-code optional-variable-view
	@ echo creating $(TO)/$(name)-$*.$($(type)) ...
	@ mkdir -p $(TO)
	@ cp $(FROM)/$*.$($(type)) $(TO)/$(name)-$*.$($(type))
	@ perl -i -pe 's{{{name}}}{$(name)}g' $(TO)/$(name)-$*.$($(type))
	@ for i in controller view; do \
		[[ -e $(TO)/$(name)-$$i.$($(type)) ]] \
		&& echo renaming $(TO)/$(name)-$$i.$($(type)) $(TO)/$(name).$($(type)) ...\
		&& mv $(TO)/$(name)-$$i.$($(type)) $(TO)/$(name).$($(type)) \
		|| true ;\
		done # posthook for controllers and views only.

