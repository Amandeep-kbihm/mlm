SimpleTokenAuthentication.configure do |config|
  config.header_names = { user: { authentication_token: 'X-User-Token', mobile_number: 'X-User-Mobile' } }

  config.identifiers = { user: 'mobile_number' }
end