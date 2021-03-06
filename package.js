Package.describe({
  name: "cxinc:github-authorization",
  summary: "Authorize users based on their github username or organization membership",
  version: "0.2.2",
  git: "https://github.com/CXInc/meteor-github-authorization"
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@0.9.1.1');

  api.use('bruz:github-api@0.2.2', ['server']);
  api.use('coffeescript', ['server']);
  api.use('accounts-base', ['server']);

  api.addFiles(['server/authorization.coffee'], ['server']);
  api.addFiles(['server/users.coffee'], 'server');

  api.export('Authorization', ['server']);
});
