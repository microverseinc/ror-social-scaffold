Warden::JWTAuth.configure do |config|
  config.secret = ENV['DEVISE_JWT_SECRET_KEY']
  config.dispatch_requests = [
    ['POST', %r{^/api/login$}],
    ['POST', %r{^/api/login.json$}]
  ]
  config.revocation_requests = [
    ['DELETE', %r{^/api/logout$}],
    ['DELETE', %r{^/api/logout.json$}]
  ]
end
