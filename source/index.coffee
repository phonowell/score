{app, BrowserWindow} = require 'electron'

win = null

app.on 'window-all-closed', ->
  app.quit()

app.on 'ready', ->

  option =
    width: 240
    height: 120
    useContentSize: true
    resizable: false
    minimizable: true
    maximizable: false
    alwaysOnTop: true
    fullscreen: false
    fullscreenable: false
    skipTaskbar: true
    show: false
    acceptFirstMouse: true
    autoHideMenuBar: true
    backgroundColor: '#fff'
    webPreferences:
      devTools: false
      nodeIntegration: true
  win = new BrowserWindow option

  win.loadURL "file://#{__dirname}/index.html"

  unless option.webPreferences.devTools == false
    win.openDevTools()

  win.on 'closed', ->
    win = null

  win.once 'ready-to-show', ->
    win.show()