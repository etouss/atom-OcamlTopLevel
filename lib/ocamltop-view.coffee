{View} = require 'atom'

module.exports =
class OcamltopView extends View
  @content: ->
    console.log "Connard"
    @div class: 'ocamltop overlay from-top', =>
      @div "Erreur le fichier n'est pas un fichier .ml", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "ocamltop:toplevel", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "OcamltopView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
