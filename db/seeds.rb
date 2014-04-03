Provider.create! [{
  name:                   'Microsoft',
  issuer:                 'https://sts.windows.net/b4ea3de6-839e-4ad1-ae78-c78e5c0cdc06/',
  identifier:             '7db0f079-8e21-4914-9a9b-0896c80f4816',
  secret:                 'Mp8EAXSOlVOeQaAlAADwtboofkUd8gycok8TvTGmKHM = ',
  scopes_supported:       [:openid, :profile, :email],
  authorization_endpoint: 'https://login.windows.net/b4ea3de6-839e-4ad1-ae78-c78e5c0cdc06/oauth2/authorize',
  token_endpoint:         'https://login.windows.net/b4ea3de6-839e-4ad1-ae78-c78e5c0cdc06/oauth2/token',
  userinfo_endpoint:      'https://login.windows.net/b4ea3de6-839e-4ad1-ae78-c78e5c0cdc06/oauth2/userinfo',
  jwks_uri:               'https://login.windows.net/common/discovery/keys'
}, {
  name:                   'mixi',
  issuer:                 'https://mixi.jp',
  identifier:             'd7573a9ad2a9d6a41ebc',
  secret:                 '199c0c8e204227343d36d50100b601c9c1651184',
  scopes_supported:       [:openid, :profile],
  authorization_endpoint: 'https://mixi.jp/connect_authorize.pl',
  token_endpoint:         'https://secure.mixi-platform.com/2/token',
  userinfo_endpoint:      'https://api.mixi-platform.com/2/openid/userinfo'
}]