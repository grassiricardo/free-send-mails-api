require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [Rails.application.secrets.secret_key_access, Rails.application.secrets.secret_key_password]
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['DATA_QUEUE_HOST']}:6379/5" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['DATA_QUEUE_HOST']}:6379/5" }
end
