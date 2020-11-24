Work environment
================

My computing environment setup expressed in code.


Installation
------------

Execute the bootstrap script from `$HOME` directory:

    bash <(curl -fsSL https://raw.githubusercontent.com/fredym/workenv/master/bootstrap.sh)

This will prepare the computer to continue the installation of software and
configuration files. This script will:

* Set bash as the default shell.
* Install XCode command line tools, if not already installed.
* Clone this repo.
* Set a new hostname (I don't like the default `Fredy's-MacBook-Pro.local`).

Changing the hostname requires a reboot. After rebooting you can continue the
setup process from the `workenv` directory:

    cd $HOME/own/workenv
    bash setup.sh



config
------

The most relevant configuration files are stored in this directory and symlinked
from `$HOME` by `setup.sh`.



tools
-----

There are some simple tasks I often run but for which there is no command line
tool yet available so I just create one and add it here. These tools are
designed and built to run on **macOS**, although I've managed to run them on
**Windows** and **Linux** with a few tweaks.



### docker_overview

Displays on screen a report of the current status of:

- Docker machines
- Default Docker machine disk size
- Docker images
- Docker containers

**Depends on:** [docker]



### drae

Searches the term specified in the first argument in the [_Diccionario de la
lengua española_][dle]. As an Spanish native speaker this comes in handy when
doing some writing.

**Depends on:** [lynx]

**Usage example**

    $ drae diccionario
       diccionario.

       Del b. lat. dictionarium.

       1. m. Repertorio en forma de libro o en soporte electrónico en el que
       se recogen, según un orden determinado, las palabras o expresiones de
       una o más lenguas, o de una materia concreta, acompañadas de su
       definición, equivalencia o explicación.

       2. m. Catálogo de noticias o datos de un mismo género, ordenado
       alfabéticamente. Diccionario bibliográfico, biográfico, geográfico.

       Real Academia Española © Todos los derechos reservados



### git_overview

Displays on screen a report of the current git repository:

- Local branches
- Last 10 commits for the curren branch
- Index status
- Stash status
- Remote origin status

**Depends on:** [git]



### pass

A password generation tool. Based on the generator written by [Benoit Mortgat]
and published by [Simon Sheppard]. Asks for a _master password_ and a _key_ to
produce a twenty-character string. This way I can have different passwords for
different services instead of using the same one every time. The best of all is
that I don't need a secure storage to keep my passwords safe.

**Depends on:** [perl]



### bk

A convenient way to manually backup important files into a safe place. This can
be scheduled when needed.



### kb

A convenient way to manually restore important files from a safe place. I don't
use this frequently, mostly when I'm setting up a new workstation.




[brew]: http://brew.sh/
[Benoit Mortgat]: http://ss64.com/pass/command-line.html
[dle]: http://dle.rae.es/
[lynx]: http://lynx.invisible-island.net/
[perl]: https://www.perl.org
[Simon Sheppard]: https://github.com/salsifis/ss64-password-generators
[docker]: https://docs.docker.com
[git]: https://git-scm.com
