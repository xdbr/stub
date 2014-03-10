stub
====

stunningly simple & stupid language agnostic project generator

With *stub*, you can create new projects instantly and have the most essential parts renamed and substituted.

Likewise, you can use *stub* to create new classes inside existsing projects in a second.

## Installation
Run
    
    curl --silent https://raw.github.com/xdbr/stub/master/install.sh | $SHELL

...and follow the instructions

## Usage

### Stubbing out a project

#### Using local template

    stub template:new template=cpp to=var/foo name=foobar version=1.2.3

#### Using remote (git-repo) template

    stub template:new template=http://path/to/repo.git to=var/bar name=foobar version=1.2.3

#### Finding out about variables that need to be set / optionally can be set

    stub template:info template=template-name

### Defining a project stub

1. Generate your skeleton of how you want your files and folders to be layed out
2. substitute all variables with mustaches that you liked to be filled in, e.g. `class {{classname}}`. This will be set by using `stub project new template=yourtemplatename classname=foo`
3. write a file `project.json`, put it in the top directory of you skeleton.
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

## Finding all tasks

    stub -T
    stub --tasks

## Listing all templates

    stub template:list

## Author

Daniel B <daniel@codeedition.de>

## License

WTFPL