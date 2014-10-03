{View} = require 'atom'

module.exports =
class OcamltopView extends View
  @content: ->
    @div class: 'ocamltop overlay from-bottom', =>
      @div "The Ocamltop package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "ocamltop:toggle", => @toggle()

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
