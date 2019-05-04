class M

  ###
  data
  maker
  notifier

  bind()
  bindClose()
  bindDrag()
  bindLong()
  bindPick()
  execute()
  info(message)
  send(path)
  ###

  data: {}
  maker: require '../ghost/maker.js'
  notifier: require 'node-notifier'

  bind: ->

    @bindClose()
    @bindDrag()
    @bindLong()
    @bindPick()
    
    @ # return

  bindClose: ->

    $btn = $ '#btn-close'

    $btn.on 'click', ->
      window.close()

    @ # return

  bindDrag: ->

    $root = $ document

    $root.on 'dragover', (e) ->
      e.preventDefault()
      e.stopPropagation()

    $root.on 'drop', (e) =>
      e.preventDefault()
      e.stopPropagation()

      {path} = e.originalEvent.dataTransfer.files[0]
      
      @send path

    @ # return

  bindLong: ->

    $ipt = $ '#ipt-long'

    $ipt.on 'change', =>

      val = $ipt.val()

      unless val?.length
        $ipt.val val = 400

      unless 200 <= val <= 1e3
        $ipt.addClass 'status-error'
        @info '节拍时长应在200ms到1000ms之间'
        @data.long = null
        return @

      $ipt.removeClass 'status-error'
      @data.long = val

    $ipt.triggerHandler 'change'

    @ # return

  bindPick: ->

    $picker = $ '#picker'
    $ipt = $ '#ipt-file'

    $picker.on 'click', ->
      $ipt.click()

    $ipt.on 'change', (e) =>
      
      {path} = $ipt[0].files[0]
      
      unless path?.length
        return

      @send path

    @ # return

  execute: ->

    @bind()

    @ # return

  info: (message) ->

    unless message?.length
      return

    title = 'Score Maker'
    @notifier.notify {title, message}

    message # return

  send: (path) ->
    
    unless path?.length
      return @info '非法路径'

    listPath = path.split ''
    extname = listPath[(listPath.length - 4)...].join ''
    unless extname == '.txt'
      return @info '乐谱文件名后缀应为.txt'

    unless @data.long
      return @info '节拍时长应在200ms到1000ms之间'

    try await @maker.execute_
      source: path
      long: @data.long
    catch e
      return @info e

    @info '编译完成'
    
    @ # return

# return
m = new M()
m.execute()