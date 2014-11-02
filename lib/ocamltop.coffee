url = require 'url'
{MessagePanelView, LineMessageView} = require 'atom-message-panel'
sys = require('sys')
exec = require('child_process').exec
fs = require 'fs'

HtmlPreviewView = require './renderOcaml'
url = require 'url'

module.exports =
  htmlPreviewView: null

  activate: (state) ->
    @editors = []
    messages = new MessagePanelView rawTitle: true, title: \
          '<font color="red" >Ocaml Top Interpréteur</font>'
    atom.workspaceView.command "ocamltop:toplevel", => @toplevel(messages)
    atom.workspace.registerOpener (uriToOpen) ->
      try
        {protocol, host, pathname} = url.parse(uriToOpen)
      catch error
        return

      return unless protocol is 'html-preview:'

      try
        pathname = decodeURI(pathname) if pathname
      catch error
        return

      if host is 'editor'
        new HtmlPreviewView(editorId: pathname.substring(1))
      else
        new HtmlPreviewView(filePath: pathname)


  getUserHome: ->
    process.env.HOME or process.env.HOMEPATH or process.env.USERPROFILE

  toplevel: (messages) ->
    { spawn } = require 'child_process'
    {EventEmitter} = require 'events'
    home = @getUserHome()
    editor = atom.workspace.getActivePaneItem()

    Array::include = (term) -> @indexOf(term) isnt -1

#une liste d'editeur serait bien mieux
    if not @editors.include editor
      editor = atom.workspace.getActivePaneItem()
      callback = =>
        console.log "save"
        @toplevel messages
      editor.onDidSave callback
      @editors.push editor


    userPanel = atom.workspace.getActivePane()

    # Message d'erreur
    messages.close()
    messages.clear()

    file = editor?.buffer.file # Donne l'Objet du fichier courant
    #filePath = file?.path

    # extrait le chemin "absolu" du fichier courant
    f = file.getPath()
    # nom du fichier courant
    file_name = "#{ file.getBaseName() }"#.replace /.ml/, ""

    #test si ML
    strings = file_name.split "."
    if strings[strings.length-1].length != 2 or \
            strings[strings.length-1].charAt(0) != 'm' or\
            strings[strings.length-1].charAt(1) != 'l'

      messages.attach()
      messages.add new LineMessageView file : file_name, message: \
                            'Erreur le fichier n\'est pas un fichier .ml'
      return
    # chemin vers le fichier tmp Interprété

    uri2 = "/tmp/atom-run-tmp-#{ file_name }"

    console.log "#{ f }"
    exec "env -i /usr/local/bin/ocaml -noprompt -nopromptcont < #{ f } > #{ uri2 }; ~/.opam/system/bin/caml2html #{uri2} -o #{ uri2 }.html" , =>
      fileText = fs.readFileSync("#{ uri2 }.html").toString()
      exec "env -i rm #{ uri2 };env -i rm #{ uri2 }.html"

      editor = atom.workspace.getActiveEditor()
      return unless editor?

      uri = "html-preview://editor/#{editor.id}"

      previousActivePane = atom.workspace.getActivePane()
      atom.workspace.open(uri, split: 'right', searchAllPanes: true).done (htmlPreviewView) =>
        if htmlPreviewView instanceof HtmlPreviewView
          console.log "reste"
          htmlPreviewView.renderHTML(fileText)
          previousActivePane.activate()


  deactivate: ->
    @messages.close()
    @ocamltopView.destroy()

  serialize: ->
    ocamltopViewState: @ocamltopView.serialize()
