class M

  ###
  maker

  bind()
  bindPicker()
  bindRoot()
  execute()
  info(message)
  send(path)
  ###

  maker: require './module.js'

  bind: ->

    @bindRoot()
    @bindPicker()
    
    @ # return

  bindInfo: ->

    $el = $ '#info'

    $el.on 'click', ->
      $el.addClass 'hidden'

    @ # return

  bindPicker: ->

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

  bindRoot: ->

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

  execute: ->

    @bind()

    @ # return

  info: (message) ->

    unless message?.length
      return

    new Notification 'Score Maker',
      body: message

    message # return

  send: (path) ->
    
    unless path?.length
      return @info '非法路径'

    listPath = path.split ''
    extname = listPath[(listPath.length - 4)...].join ''
    unless extname == '.txt'
      return @info '乐谱文件名后缀应为.txt'

    long = $('#ipt-long').val() or 400
    unless 200 <= long <= 2000
      return @info '节拍时长应在200ms到2000ms之间'

    try await @maker.execute_
      source: path
      long: long
    catch e
      return @info e

    @info '编译完成'
    
    @ # return

# return
m = new M()
m.execute()