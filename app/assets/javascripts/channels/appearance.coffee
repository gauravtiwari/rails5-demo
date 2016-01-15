App.appearance = App.cable.subscriptions.create "AppearanceChannel",
  timeoutID = undefined
  connected: ->
    @install()
    @setup()

  disconnected: ->
    @uninstall()

  rejected: ->
    @uninstall()

  install: ->
    $(document).on "page:change.appearance", =>
      @appear()
      @setup()

  appear: ->
    @perform("appear")
    @setup()

  away: ->
    @perform("away")

  uninstall: ->
    $(document).off(".appearance")

  setup: ->
    @addEventListener 'mousemove', @resetTimer(), false
    @addEventListener 'mousedown', @resetTimer(), false
    @addEventListener 'keypress', @resetTimer(), false
    @addEventListener 'DOMMouseScroll', @resetTimer(), false
    @addEventListener 'mousewheel', @resetTimer(), false
    @addEventListener 'touchmove', @resetTimer(), false
    @addEventListener 'MSPointerMove', @resetTimer(), false
    startTimer()
    return

  startTimer: ->
    # wait 5 minutes before calling goInactive
    timeoutID = window.setTimeout(setAway, 2000)
    return

  resetTimer: (e) ->
    window.clearTimeout timeoutID
    setActive()
    return

  setAway: ->
    @away()
    return

  setActive: ->
    @appear()
    startTimer()
    return
