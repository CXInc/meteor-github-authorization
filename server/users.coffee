Meteor.users.find({}).observe
  added: (user) ->
    unless user.authorized
      Authorization.authorize(user)
