OcamltopView = require './ocamltop-view'
url = require 'url'

module.exports =
  ocamltopView: null

  activate: (state) ->
    atom.workspaceView.command "ocamltop:toplevel", => @toplevel()

  getUserHome: ->
    process.env.HOME or process.env.HOMEPATH or process.env.USERPROFILE

  toplevel: ->
    { spawn } = require 'child_process'
    {EventEmitter} = require 'events'
    fs = require 'fs'
    #emitter = require 'emitter'
    #emitter.setMaxListeners 100
    #ls = spawn '/Users/ByTeK/.atom/packages/ocamltop/node_modules/Ocaml_Interpreteur.sh'
    #ls.stdout.on 'data', ( data ) -> console.log "Output: #{ data }"
    #ls.stderr.on 'data', ( data ) -> console.error "Error: #{ data }"
    #ls.on 'close', -> console.log "'ls' has finished executing."

    home = @getUserHome()
    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer.file
    filePath = file?.path
    #directoryPath = atom.project.getPath()
    f = file.getPath()
    file_name = "#{ file.getBaseName() }"#.replace /.ml/, ""

    uri = "#{ home }/.atom/packages/ocamltop/temp/#{ file_name }"

    foo = -> fs.readFileSync filePath, 'utf8'
    string = foo().toString()
    # tempStream = fs.createWriteStream(uri,\
    #    {flags: 'w'});
    #console.log "#{ uri }"

    ocaml = spawn "#{ home }/.atom/packages/ocamltop/node_modules/Ocaml_Interpreteur.sh",["#{ f }","#{ uri }"]
    ocaml.once 'close', -> console.log "'ocaml' has finished executing."
    ocaml.exit

    previewPane = atom.workspace.paneForUri(uri)
    if previewPane
      return

    previousActivePane = atom.workspace.getActivePane()
    atom.workspace.open(uri, split: 'right', searchAllPanes: true).done


  deactivate: ->

    @ocamltopView.destroy()

  serialize: ->
    ocamltopViewState: @ocamltopView.serialize()
