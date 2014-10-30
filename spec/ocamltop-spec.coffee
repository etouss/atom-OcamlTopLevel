{WorkspaceView} = require 'atom'
Ocamltop = require '../lib/ocamltop'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Ocamltop", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('ocamltop')

  describe "when the ocamltop:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.ocamltop')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'ocamltop:toggle'


      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.ocamltop')).toExist()
        atom.workspaceView.trigger 'ocamltop:toggle'
        expect(atom.workspaceView.find('.ocamltop')).not.toExist()
