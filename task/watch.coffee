$ = require 'fire-keeper'

class M

  ###
  bind()
  compile_(source, option = {})
  copy_(source)
  exclude()
  execute()
  reloadCss()
  watchCoffee()
  watchPug()
  watchStyl()
  watchText()
  ###

  bind: ->
    process.on 'uncaughtException', (e) ->
      $.i e.stack
    @ # return

  compile_: (source, option = {}) ->

    target = $.getDirname source
    .replace /\/source/, '/build'
    .replace /\/{2,}/g, '/'

    option.map ?= true
    option.minify ?= false

    await $.compile_ source, target, option

    @ # return

  copy_: (source) ->

    target = $.getDirname source
    .replace /\/source/, '/build'
    .replace /\/{2,}/g, '/'

    await $.copy_ source, target

    @ # return

  exclude: $.fn.excludeInclude

  execute: ->

    @bind()

    # coffee
    listSource = @exclude './source/**/*.coffee'
    $.watch listSource, (e) => await @compile_ e.path

    # js
    listSource = @exclude './source/**/*.js'
    $.watch listSource, (e) => await @copy_ e.path
    # pug
    listSource = @exclude './source/**/*.pug'
    $.watch listSource, (e) => await @compile_ e.path

    # styl
    listSource = @exclude './source/**/*.styl'
    $.watch listSource, (e) => await @compile_ e.path

    # txt
    listSource = @exclude './source/**/*.txt'
    $.watch listSource, (e) => await @copy_ e.path
    
    # reload css
    $.reload './build/**/*.css'

    @ # return

# return
module.exports = ->

  m = new M()
  m.execute()