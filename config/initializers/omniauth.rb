Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.on_failure = SessionsController.action(:destroy)
  provider :facebook, ENV["facebook_app_id"], ENV["facebook_app_secret"]
  provider :twitter, ENV["twitter_app_id"], ENV["twitter_app_secret"]
  provider :google_oauth2,
           ENV["google_app_id"],
           ENV["google_app_secret"],
           skip_jwt: true
end
