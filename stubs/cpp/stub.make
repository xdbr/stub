# 
# Varaibles at your disposal:
#
#  $(T)  -- template's origin directory
#  $(TO) -- template's destination directory 
default: help

help:
	@echo this is help-template from stub/cpp

new: guard-TO
	cp $(T)/*.cpp $(TO)/
	perl -i -pes{{{author}}}{$(author)} $(TO)/*.cpp

class: class-variables new # create a new class and rename the file
	mv $(TO)/file1.cpp $(TO)/$(name).cpp

class-variables: variable-name guard-name