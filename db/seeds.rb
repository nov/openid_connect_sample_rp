attributes = if Rails.env.development?
  {
    identifier: '6e14c307831c15978ef954fc6d08bdaa',
    secret: '76c9db9a7dc001de84951b6e60850ee12a997b5f8d3f9bcfe612b4d2d7d28213',
    host: 'op.dev',
    scheme: 'http'
  }
else
  {
    identifier: '333e306219ee214949a2d5565fda9a07',
    secret: '2880fc37a047929030b730c80e3bcb6228e57b7859149270fac274e273c79d03',
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