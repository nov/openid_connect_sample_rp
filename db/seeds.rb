Provider.destroy_all

Provider.create! [{
  name:                   'Microsoft',
  issuer:                 'https://login.microsoftonline.com/d2f17455-673e-4168-aede-c31b83cf0a3b/v2.0',
  identifier:             'c6ca85c3-7aaa-4162-9bbc-ce4e69b492b7',
  secret:                 'VhrjtecSvQFT6CmybFLLsdf',
  scopes_supported:       [:openid, :profile, :email, 'User.Read'],
  authorization_endpoint: 'https://login.microsoftonline.com/d2f17455-673e-4168-aede-c31b83cf0a3b/oauth2/v2.0/authorize',
  token_endpoint:         'https://login.microsoftonline.com/d2f17455-673e-4168-aede-c31b83cf0a3b/oauth2/v2.0/token',
  userinfo_endpoint:      'https://graph.microsoft.com/me',
  jwks_uri:               'https://login.microsoftonline.com/d2f17455-673e-4168-aede-c31b83cf0a3b/discovery/v2.0/keys'
}]

Provider.create!({
  issuer: "#{ENV['PROVIDER_BASE_URL']}/auth/realms/MyRealm",
  authorization_endpoint: "#{ENV['PROVIDER_BASE_URL']}/auth/realms/MyRealm/protocol/openid-connect/auth",
  token_endpoint: "#{ENV['PROVIDER_BASE_URL']}/auth/realms/MyRealm/protocol/openid-connect/token",
  userinfo_endpoint: "#{ENV['PROVIDER_BASE_URL']}/auth/realms/MyRealm/protocol/openid-connect/userinfo",
  jwks_uri: "#{ENV['PROVIDER_BASE_URL']}/auth/realms/MyRealm/protocol/openid-connect/certs",
  name: "keycloak",
  identifier: ENV['CLIENT_ID'],
  scopes_supported: ["Manager"],
  secret: ENV['SECRET']})
