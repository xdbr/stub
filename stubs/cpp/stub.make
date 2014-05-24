# 
# Variables at your disposal:
#
#  $(FROM)  -- template's origin directory
#  $(TO)    -- template's destination directory 

# 
# You can also define your own variables: Simply state after each target,
# which variables are required and which ones are optional
# 
# For a required variable
#   target-name: required-variable-VARNAME
# 
# For an optional variable
#   target-name: optional-variable-VARNAME

default: help

help: description targets

description:
	@echo A stub to create a whole C++-Project or individual classes

targets: target-new target-class
target-new:   ;	@echo "  new   -- create a C++-project"
target-class: ;	@echo "  class -- create a C++-class and rename the file"

new: required-variable-TO optional-variable-author
	cp $(FROM)/*.cpp $(TO)/
	perl -i -pe 's{{{author}}}{$(author)}g' $(TO)/*.cpp

class: required-variable-TO \
			 required-variable-name \
			 optional-variable-author
	mkdir -p $(TO)
	cp $(FROM)/file1.cpp $(TO)/$(name).cpp

class-variables: 