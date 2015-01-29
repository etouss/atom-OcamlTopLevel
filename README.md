You may want to have a look on REPL : https://atom.io/packages/repl which a similar job but better.
This package is abandonned sorry.
# ocamltop package

First let me give back to cesear what he derserve and thanks
- https://github.com/jgarth/runcoderun and Joachim Garth.
- https://github.com/webBoxio/atom-html-preview and Fatih Kadir Akın.

Then to use you will need Ocaml, and Opam

##Description
OcamlTop-Html give you a way to execute Ocaml-Top-Level directly in Atom.

ScreenShot Bellow:
![screen shot](http://i.imgur.com/RasigL7.png)

## Installing
### Requirements
1. Install caml2html with opam `opam install caml2html`

```apm install ocamltop-html```

Cause we are beginners in Atom Packages i am not able to create a config file so:
Please change Ocaml path in lib/ocamltop.coffee ligne 87.

### in Linux
`ocaml`

### in OSX
`/usr/local/bin/ocaml`


## Usage

`ctrl-i`: toggle ocamltop-html

render file are relooad on save

TODO:
Config File
