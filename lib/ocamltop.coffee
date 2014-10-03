OcamltopView = require './ocamltop-view'


module.exports =
  ocamltopView: null

  activate: (state) ->
    atom.workspaceView.command "ocamltop:toplevel", => @toplevel()

  toplevel: ->
    { spawn } = require 'child_process'
    {EventEmitter} = require 'events'
    fs = require 'fs'
    #emitter = require 'emitter'
    #emitter.setMaxListeners 100
    #ls = spawn 'ls '
    #ls.stdout.on 'data', ( data ) -> console.log "Output: #{ data }"
    #ls.stderr.on 'data', ( data ) -> console.error "Error: #{ data }"
    #ls.on 'close', -> console.log "'ls' has finished executing."

    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer.file
    filePath = file?.path
    directoryPath = atom.project.getPath()

    topStream = fs.createWriteStream("#{ directoryPath }/toplevel.ml", {flags: 'a'});
    foo = -> fs.readFileSync filePath, 'utf8'
    string = foo().split ";;"

    tempStream = fs.createWriteStream("#{ directoryPath }/temp.ml", {flags: 'w'});

    for str in string
      ecrire = spawn 'echo' , ["#{ str };;"]
      ecrire.stdout.pipe(tempStream)# 'data',(data) -> console.log "Output: #{ data }"
      ecrire.stderr.pipe(tempStream)# -> console.log "Error: #{ data }"
      ecrire.once 'close', -> console.log "'ecrire' has finished executing."
      ecrire.exit

      ocaml = spawn '/usr/local/bin/ocamlc', ['-i',"#{ directoryPath }/temp.ml"]
      ocaml.stdout.pipe(topStream)# 'data',(data) -> console.log "Output: #{ data }"
      ocaml.stderr.pipe(topStream)# -> console.log "Error: #{ data }"
      ocaml.once 'close', -> console.log "'ocamlc -i' has finished executing."
      ocaml.exit

    return

  deactivate: ->
    #@ocamltopView.destroy()

  serialize: ->
    ocamltopViewState: @ocamltopView.serialize()
