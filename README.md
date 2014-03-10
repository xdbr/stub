stub
====

stunningly simple & stupid language agnostic project generator

With *stub*, you can create new projects instantly and have the most essential parts renamed and substituted.

Likewise, you can use *stub* to create new classes inside existsing projects in a second.

## Example

* Stub-template example:

    `https://github.com/xdbr/stub-template-typesetting`

* Project generated / substitutions made:

<!--  -->

    .                                           .--------[ main.pandoc ] --------------.
    |-- README.md                               | % {{head1}}   <-- these will         |
    |-- Rakefile                                | % {{head2}}   <-- be stubstituted    |
    |-- bibliography.bib                        | % {{head3}}   <-- by stub            |
    |-- chapters                                |                                      |
    |   |-- 100-Introduction.pandoc             | <#include resources/gpp-defines.gpp> |
    |   |-- 200-Examples.pandoc                 |                                      |
    |   `-- 900-End.pandoc                      | <#part Part I>                       |
    |-- main.pandoc  ---D E T A I L  V I E W--->|                                      |
    |-- project.json                            | # Introduction                       |
    `-- resources                               |                                      |
        |-- ditaa                               | [...]                                |
        |   `-- typesetting-process.ditaa       |                                      |
        `-- gpp-defines.gpp                     '--------------------------------------'
<!--  -->

* Command used

    `stub template:new template=https://github.com/xdbr/stub-template-typesetting to=destinaton-dir head1=foobar`

## Installation
Run
    
    curl --silent https://raw.github.com/xdbr/stub/master/install.sh | $SHELL

...and follow the instructions

## Usage

### Stubbing out a project

    stub template:new template=TEMPLATE-NAME to=DESTINATION_DIR variable1=value1 variable2=value2 ...

    stub template:new template=http://path/to/repo.git to=DESTINATION_DIR variable1=value1 variable2=value2 ...

#### Finding out about variables that need to be set / optionally can be set

    stub template:info template=TEMPLATE-NAME-or-path-to-repo


## Creating projects stubs
Creating a project stub to be reused is straightforward and simple. Here's a quick rundown:

### Defining a project stub

1. Generate your skeleton of how you want your files and folders to be layed out
2. substitute all variables with mustaches that you liked to be filled in, e.g. `class {{classname}}`. This will be set by using `stub project new template=yourtemplatename classname=foo`
3. write a file `project.json`, put it in the top directory of your skeleton.
4. Use the following layout for your `project.json`:

```
    {
      "requires": {
        "name"   : "string",
        "version": "versionstring"
      },
      "optional": {
        "author": "Quux"
      }
    }
```

Note that:

a) in this example, the variables `name` and `version` will be required upon using this stub
b) the optional variables *can* be set (name="me") or their default values will be used ("Quux")
c) the definitions `string` and `versionstring` only carry an informative value, but will not be validated

## More Usage

### Finding all tasks

    stub -T
    stub --tasks

### Listing all templates

    stub template:list

## Author

Daniel <dbrx@crux.uberspace.de>

## License

WTFPL