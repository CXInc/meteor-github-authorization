Package.describe({
  summary: "Authorize users based on their github username or organization membership",
  version: "0.1.0",
  git: "https://github.com/CXInc/meteor-github-authorization"
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@0.9.1.1');

  api.use('bruz:github-api@0.2.2', ['server']);
  api.use('coffeescript', ['server']);

  api.addFiles(['server/authorization.coffee'], ['server']);
  api.addFiles(['server/users.coffee'], 'server');
  api.addFiles(['client/account_permissions.coffee'], 'client');

  api.export('Authorization', ['server']);
});
