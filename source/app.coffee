{app, BrowserWindow} = require 'electron'

win = null

app.on 'window-all-closed', ->
  app.quit()

app.on 'ready', ->

  isDebug = true

  option =
    width: 240
    height: 188
    useContentSize: true
    resizable: isDebug
    minimizable: false
    maximizable: false
    alwaysOnTop: true
    fullscreen: false
    fullscreenable: false
    show: false
    frame: false
    acceptFirstMouse: true
    autoHideMenuBar: true
    transparent: true
    webPreferences:
      devTools: isDebug
      nodeIntegration: true
  win = new BrowserWindow option

  win.loadURL "file://#{__dirname}/shell/index.html"

  if isDebug
    win.openDevTools()

  win.on 'closed', ->
    win = null

  win.once 'ready-to-show', ->
    win.show()