$ = require 'fire-keeper'

class M

  ###
  mapPlatform

  execute_()
  ###

  mapPlatform:
    darwin: 'darwin'
    macos: 'darwin'
    win32: 'win32'
    windows: 'win32'

  execute_: ->

    await $.task('build')()

    platform = @mapPlatform[$.os]
    platform or throw new Error "invalid platform '#{platform}'"

    cmd = [
      'electron-packager .'
      '--electronVersion=5.0.0'
      "--platform=#{platform}"
    ].join ' '

    await $.exec_ cmd
   
    @ # return


# return
module.exports = ->

  m = new M()
  await m.execute_()