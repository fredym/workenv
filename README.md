Work environment
================

My computing environment setup expressed in code.


Installation
------------

Clone this repo and run `setup.sh`. This will install a bunch of software using
[brew]. Then the configuration files of some of these tools will be overwritten.

_WARNING: `setup.sh` will set the computer name to `aleph`. You need to edit
`setup.sh` and specify yours. This is being tracked on #9._

    $ cd
    $ git clone https://github.com/fredym/workenv.git
    $ cd workenv
    $ chmod +r setup.sh
    $ ./setup.sh



config
------

The most relevant configuration files are stored in this directory and symlinked
from `$HOME` by `setup.sh`.



tools
-----

There are some simple tasks I do very often but for which there is no command
line tool yet available so I just create one and add it here. These tools are
designed for **Mac OS X**.



### docker_overview

Displays on screen a report of the current status of:

- Docker machines
- Default Docker machine disk size
- Docker images
- Docker containers



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



### pass

A password generation tool. Based on the generator written by [Benoit Mortgat]
and published by [Simon Sheppard]. Asks for a _master password_ and a _key_ to
produce a twenty-character string. This way I can have different passwords for
different services instead of using the same one every time. The best of all is
that I don't need a secure storage to keep my passwords safe.

**Depends on:** [perl]




[brew]: http://brew.sh/
[Benoit Mortgat]: http://ss64.com/pass/command-line.html
[dle]: http://dle.rae.es/
[lynx]: http://lynx.invisible-island.net/
[perl]: https://www.perl.org
[Simon Sheppard]: https://github.com/salsifis/ss64-password-generators
