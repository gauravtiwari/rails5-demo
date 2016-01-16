App.appearance = App.cable.subscriptions.create "AppearanceChannel",
  connected: ->
    @install()
    @trackStatus()

  disconnected: ->
    @uninstall()

  rejected: ->
    @uninstall()

  install: ->
    $(document).on 'page:change', -> App.appearance.appear()

  away: ->
    @perform("away")
    App.CurrentUser().setAway()

  appear: ->
    @perform("appear")
    App.CurrentUser().setOnline()

  uninstall: ->
    $(document).off(".appearance")

  trackStatus: ->
    App.CurrentUser().setOnline()
    $(document).idle
      onIdle: ->
        App.appearance.away()
        return
      onActive: ->
        App.appearance.appear()
        return
      idle: 5000
