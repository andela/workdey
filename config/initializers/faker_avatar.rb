Faker::Avatar.class_eval do
  def self.image(slug = nil, size = '300', format = 'png')
    slug ||= Faker::Lorem.words.join
    "https://api.adorable.io/avatars/#{size}/#{slug}.#{format}"
  end
end
