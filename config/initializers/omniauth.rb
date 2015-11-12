Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["facebook_app_id"], ENV["facebook_app_secret"], scope: "email"
  provider :twitter, ENV["twitter_app_id"], ENV["twitter_app_secret"]
  provider :google_oauth2, ENV["google_app_id"], ENV["google_app_secret"]
end