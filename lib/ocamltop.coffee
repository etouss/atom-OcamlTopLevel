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
    home = @getUserHome()
    editor = atom.workspace.getActivePaneItem()

    file = editor?.buffer.file # Donne l'Objet du fichier courant
    #filePath = file?.path

    # extrait le chemin "absolu" du fichier courant
    f = file.getPath()
    # nom du fichier courant
    file_name = "#{ file.getBaseName() }"#.replace /.ml/, ""
    #test si ML
    strings = file_name.split "."
    if strings[strings.length-1].length != 2 or \
            strings[strings.length-1].charAt(0) != 'm' or \
            strings[strings.length-1].charAt(1) != 'l'
      return

    # chemin vers le fichier tmp Interprété
    uri = "#{ home }/.atom/packages/ocamltop/temp/#{ file_name }"

    # exécution du scripte qui interprete le fichier .ml
    # Et ecrit dans le fichier tmp
    ocaml = spawn "#{ home }/.atom/packages/ocamltop/node_modules/\
                    Ocaml_Interpreteur.sh",["#{ f }","#{ uri }"]
    ocaml.once 'close', -> console.log "'ocaml' has finished executing."
    ocaml.exit

    @traiter(uri)

    # fonction qui efface le fichier tmp quand
    #le fichier le fichier source est fermé
    clean = ->
      rm = spawn 'rm',["-f","#{ uri }"]
      rm.once 'close', -> console.log "'rm' has finished executing."
      rm.exit
    editor.onDidDestroy(clean)

    userPanel = atom.workspace.getActivePane() # panel du fichier source
    previewPane = atom.workspace.paneForUri(uri) # panel du fichier tmp

    # si le fichier tmp est deja ouvert on le met au premier plan de son pane
    if previewPane
      previewPane.activateItemForUri(uri)
      userPanel.activate()
      return

    # Fonction pour récupérer la main sur le fichier source
    userPanelHandle = ->
      userPanel.activate()

    # une fois le fichier tmp ouvert on réccupere la main sur la source
    atom.workspace.onDidOpen(userPanelHandle)

    # on split le panel et on ouvre le fichier tmp
    atom.workspace.open(uri, split: 'right', \
                        searchAllPanes: true, activatePane: true).done

  traiter: (uri) ->
    fs = require 'fs'
    foo = -> fs.readFileSync uri, 'utf-8'
    texte = foo()
    texte2 = ""
    for char in texte
      texte2 += char
      if char == '\n'
        texte2 += '\n'
    console.log texte2

  deactivate: ->

    @ocamltopView.destroy()

  serialize: ->
    ocamltopViewState: @ocamltopView.serialize()
