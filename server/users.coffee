Accounts.onLogin (info) ->
  if info.user
    console.log "Accounts.onLogin"
    Authorization.authorize(info.user)
