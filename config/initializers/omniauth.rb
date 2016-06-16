scopes = %w(
  userinfo.email
  userinfo.profile
  plus.me
  ).join(', ')

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.on_failure = SessionsController.action(:destroy)
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :twitter, ENV["twitter_app_id"], ENV["twitter_app_secret"]
  provider :google_oauth2,
           ENV["GOOGLE_CLIENT_ID"],
           ENV["GOOGLE_CLIENT_SECRET"],
           {
             name: "google_oauth2",
             scope: scopes,
             prompt: "select_account",
             image_aspect_ratio: "square",
             image_size: 50,
             skip_jwt: true
           }
end
