attributes = if Rails.env.development?
  {
    identifier: 'c6aca6537869459002ccec9852952f73',
    secret: '37b202400da8dbf11da0f71a3630e5daba322786675a36673bd37f325790be5e',
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
  check_id_endpoint: '/id_token',
  user_info_endpoint: '/user_info'
)

Provider.create attributes