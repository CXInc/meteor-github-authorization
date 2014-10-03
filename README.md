Meteor GitHub Authorization
===========================

A Meteor package that enables user authorization based on GitHub username or GitHub organization membership. Requires the user of GitHub authentication.

Installation
------------

meteor add cxinc:github-authorization

Usage
-----

There are three authorization methods available:

  * username - The GitHub username of the user must be on a whitelist
  * github-org - The user must belong to a specified GitHub org
  * none - Useful for testing, or if you have an app that's deployed in an internal environment without concerns of external users accessing it

Add a settings.json to your app, if you don't already have one, and then add the configuration values you'll be using:

  * authorizationMethod - Either "github-org", "username" or "none"
  * authorizedUsernames - When authorizationMethod is "username", this is the array of GitHub usernames authorized to use the app
  * org - When authorizationMethod is "github-org", this is the GitHub org name that users must belong to in order to access the app

For example:

    {
      "authorizationMethod": "github-org",
      "org": "CXInc",
    }

Somewhere in your client code, add this so that you'll get the right info from GitHub, have access to the authorization status of the user:

    Accounts.ui.config({
      requestPermissions: {
        github: ['repo']
      }
    });

    Meteor.startup(function() {
      return Deps.autorun(function() {
        return Meteor.subscribe('userData');
      });
    });

Somewhere in your server code, add this so that the authorization status fields will be exposed to the client:

    Deps.autorun(function() {
      Meteor.publish('userData', function() {
        Meteor.users.find({
          _id: this.userId
        }, {
          fields: {
            authorized: 1,
            authCheckComplete: 1
          }
        });
      });
    });

Finally, use Authorization.authorized anywhere you want to limit access. For publications this may look like:

    Meteor.publish('books', function(options) {
      if (Authorization.authorized(this.userId)) {
        return Books.find({}, options);
      } else {
        return this.stop();
      }
    });

If you use Iron Router, here's one possible way to use it with that:

    Router.onBeforeAction(function(pause) {
      var user = Meteor.user()

      if (user && user.authCheckComplete && !user.authorized) {
        this.render('unauthorized');
        return pause();
      }
    });

License
-------

MIT

