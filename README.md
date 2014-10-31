# ocamltop package

First let me give back to cesear what he derserve and thanks
- https://github.com/jgarth/runcoderun and Joachim Garth.
- https://github.com/webBoxio/atom-html-preview and Fatih Kadir Akın.

Then to use you will need Ocaml, and Opam

## Installing
### Requirements
1. Install caml2html with opam `opam install caml2html`

```apm install ocamltop-html```

Cause we are beginners in Atom Packages i am not able to create a config file so:
Please change Ocaml and caml2html path in lib/ocamltop.coffee ligne 87.

### in Linux
`ocaml` & `$HOME/.opam/system/bin/caml2html`

### in OSX
`/usr/local/bin/ocaml` & `$HOME/.opam/system/bin/caml2html`


## Usage

`ctrl-i`: toggle ocamltop-html

render file are relooad on save 

TODO:
Config File
