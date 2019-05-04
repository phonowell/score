$ = require 'fire-keeper'

class M

  ###
  execute_()
  ###

  execute_: ->

    await $.task('build')()

    await $.remove_ './dist'

    cmd = [
      'electron-builder .'
      "--#{$.os}"
      '--x64'
      '--config=./data/build.yaml'
    ].join ' '

    await $.exec_ cmd
   
    @ # return


# return
module.exports = ->

  m = new M()
  await m.execute_()