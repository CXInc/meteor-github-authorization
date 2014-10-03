Meteor.users.find({}).observe
  added: (user) ->
    Authorization.authorize(user)

Accounts.onLogin (info) ->
  Authorization.authorize(info.user)
