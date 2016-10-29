chai = require 'chai'
chai.should()

class Task
  constructor: (@name) ->
    @status = 'incomplete'

  complete: ->
    @status = 'complete'
    true

exports.Task = Task

describe 'Task instance', ->
  task = null
  it 'should have a name', ->
    task = new Task 'feed the cat'
    task.name.should.equal 'feed the cat'
  it 'should be initially incomplete', ->
    task.status.should.equal 'incomplete'
  it 'should be able to be completed', ->
    task.complete().should.be.true
    task.status.should.equal 'complete'