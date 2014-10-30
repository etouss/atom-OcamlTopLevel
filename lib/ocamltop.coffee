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
<<<<<<< HEAD
    uri2 = "#{ home }/.atom/packages/ocamltop/temp/#{ file_name }"
=======
    uri = "#{ home }/.atom/packages/ocamltop/temp/#{ file_name }"

    # traiter = ->
    #   fs = require 'fs'
    #   #foo = -> fs.readFileSync uri, 'utf-8'
    #   texte = fs.readFileSync uri, 'utf-8'
    #   texte2 = ""
    #   i = 0
    #   for char in texte
    #     i++
    #     texte2 += char
    #     if char == '\n' and i > 30
    #       texte2 += '\n'
    #   fs.writeFile uri, texte2
      #console.log texte2

    # exécution du scripte qui interprete le fichier .ml
    # et ecrit dans le fichier tmp
    console.log "#{ f }"
    exec "env -i ocaml -noprompt -nopromptcont < #{f} > #{ uri }"

    #ocaml = spawn "#{ home }/.atom/packages/ocamltop/node_modules/\
    #                Ocaml_Interpreteur.sh",["#{ f }","#{ uri }"]
    #ocaml.once 'close', traiter
    #ocaml.exit

    #@traiter(uri)
    #console.log bool
    # fonction qui efface le fichier tmp quand
    #le fichier le fichier source est fermé
    clean = ->
      rm = spawn 'rm',["-f","#{ uri }"]
      rm.once 'close', -> console.log "'rm' has finished executing."
      rm.exit
    editor.onDidDestroy(clean)

     # panel du fichier source
    previewPane = atom.workspace.paneForUri(uri) # panel du fichier tmp

    # si le fichier tmp est deja ouvert on le met au premier plan de son pane
    if previewPane
      previewPane.activateItemForUri(uri)
      userPanel.activate()
      return

    # Fonction pour récupérer la main sur le fichier source
    userPanelHandle = ->
      editorB = atom.workspace.getActivePaneItem()
      editorB.onDidDestroy(clean)
      userPanel.activate()
>>>>>>> a5e0c103d699ef60655e9667b87e6f3462e1b799

    console.log "#{ f }"
    exec "env -i /usr/local/bin/ocaml -noprompt -nopromptcont < #{ f } > #{ uri2 };env -i /Users/ByTeK/.opam/system/bin/caml2html #{uri2} -o #{ uri2 }.html" , =>
      fileText = fs.readFileSync("#{ uri2 }.html").toString()

      editor = atom.workspace.getActiveEditor()
      return unless editor?

      uri = "html-preview://editor/#{editor.id}"

      previewPane = atom.workspace.paneForUri(uri)
      if previewPane
        previewPane.destroyItem(previewPane.itemForUri(uri))
        exec "env -i rm #{ uri2 };env -i rm #{ uri2 }.html"
        return

      previousActivePane = atom.workspace.getActivePane()
      atom.workspace.open(uri, split: 'right', searchAllPanes: true).done (htmlPreviewView) ->
        if htmlPreviewView instanceof HtmlPreviewView
          console.log "reste"
          htmlPreviewView.renderHTML(fileText)
          previousActivePane.activate()


  deactivate: ->
    @messages.close()
    @ocamltopView.destroy()

  serialize: ->
    ocamltopViewState: @ocamltopView.serialize()
