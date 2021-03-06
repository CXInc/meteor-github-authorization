@Authorization =

  authorize: (user) ->
    switch Meteor.settings.authorizationMethod
      when "github-org"
        @githubOrgAuth(user)
      when "none"
        @noAuth(user)
      else
        @usernameAuth(user)

  authorized: (userId) ->
    user = Meteor.users.findOne({_id: userId})
    user && user.authorized

  githubOrgAuth: (user) ->
    token = user.services.github.accessToken

    github = new GitHub
      version: "3.0.0"
      debug: true

    github.authenticate
      type: 'oauth'
      token: token

    github.user.getOrgs {}, Meteor.bindEnvironment(
      (err, res) =>
        if err
          console.log "Authorization check failure: #{res}"
        else
          authorized = _.some res, (orgs) ->
            Meteor.settings.org == orgs.login

          Meteor.users.update user._id,
            $set:
              authCheckComplete: true
              authorized: authorized
      , (e) ->
        console.log 'bind failure'
    )

  usernameAuth: (user) ->
    username = user.services.github.username
    authorized = _.contains Meteor.settings.authorizedUsernames, username

    Meteor.users.update user._id,
      $set:
        authCheckComplete: true
        authorized: authorized

  noAuth: (user) ->
    Meteor.users.update user._id,
      $set:
        authCheckComplete: true
        authorized: true

Authorization = @Authorization
