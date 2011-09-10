attributes = if Rails.env.development?
  {
    identifier: '6e14c307831c15978ef954fc6d08bdaa',
    secret: '76c9db9a7dc001de84951b6e60850ee12a997b5f8d3f9bcfe612b4d2d7d28213',
    host: 'op.dev',
    scheme: 'http'
  }
else
  {
    identifier: 'd36b87830791a037fabf32625bf90865',
    secret: '2c1fb5d90b1066275290871e74aeed656afc1aeccc8fec4196aa726381bffff1',
    host: 'connect-op.heroku.com',
    scheme: 'https'
  }
end
attributes.merge!(
  name: 'NOV\'s OP',
  scope: 'email profile address PPID',
  authorization_endpoint: '/authorizations/new',
  token_endpoint: '/access_tokens',
  check_session_endpoint: '/id_token',
  user_info_endpoint: '/user_info',
  public_key_endpoint: '/public.crt'
)

Provider.create attributes