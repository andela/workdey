Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.on_failure = SessionsController.action(:destroy)
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :twitter, ENV["twitter_app_id"], ENV["twitter_app_secret"]
  provider :google_oauth2,
           ENV["google_app_id"],
           ENV["google_app_secret"],
           skip_jwt: true
end
