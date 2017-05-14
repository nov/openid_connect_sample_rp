Provider.create! [{
  name:                   'Microsoft',
  issuer:                 'https://login.microsoftonline.com/d2f17455-673e-4168-aede-c31b83cf0a3b/v2.0',
  identifier:             'c6ca85c3-7aaa-4162-9bbc-ce4e69b492b7',
  secret:                 'VhrjtecSvQFT6CmybFLLsdf',
  scopes_supported:       [:openid, :profile, :email],
  authorization_endpoint: 'https://login.windows.net/d2f17455-673e-4168-aede-c31b83cf0a3b/oauth2/v2.0/authorize',
  token_endpoint:         'https://login.windows.net/d2f17455-673e-4168-aede-c31b83cf0a3b/oauth2/v2.0/token',
  userinfo_endpoint:      'https://graph.microsoft.com/me',
  jwks_uri:               'https://login.windows.net/d2f17455-673e-4168-aede-c31b83cf0a3b/discovery/v2.0/keys'
}]