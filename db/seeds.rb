class SeedData
  def users_list
    cloudinary_img_url =
      "http://res.cloudinary.com/dxoydowjy/image/upload/v1452076402/"\
      "rxxvqznd6ayvqlmxoon2.png"
    [
      { firstname: "Olaide", lastname: "Ojewale",
        email: "olaide.ojewale@andela.com", street_address: "55 Moleye Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq",
        confirmed: true, has_taken_quiz: true,
        image_url: cloudinary_img_url,
        latitude: "6.5001035", longitude: "3.376697" },
      { firstname: "Chinedu", lastname: "Daniel",
        email: "chinedu.daniel@andela.com", street_address: "55 Moleye Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "tasker", confirmed: true,
        confirm_token: "112ewqee2123wqwqw12wq",
        image_url: cloudinary_img_url,
        latitude: "6.4994906", longitude: "3.3780381" },
      { firstname: "Temitope", lastname: "Amodu",
        email: "temitope.amodu@andela.com", street_address: "2 Funso Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "tasker", confirmed: true,
        confirm_token: "112ewqee2123wqwqw12wq",
        image_url: cloudinary_img_url,
        latitude: "6.5066561", longitude: "3.3816401" },
      { firstname: "Ruth", lastname: "Chukwumam",
        email: "ruth.chukwumam@andela.com", street_address: "44 Isaac John",
        city: "GRA", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq",
        confirmed: true, has_taken_quiz: true, image_url: cloudinary_img_url,
        latitude: "6.5275368", longitude: "3.367699" },
      { firstname: "Chinedu", lastname: "Dan",
        email: "chinedu.dan@andela.com", street_address: "34, Adeyemo Alakija",
        city: "VI", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq",
        image_url: cloudinary_img_url,
        latitude: "6.4377563", longitude: "3.4232642" },
      {
        firstname: "Hubert", lastname: "Nakitare",
        email: "hubert.nakitare@andela.com",
        street_address: "525, Kindaruma Road", city: "Nairobi",
        state: "Nairobi", password: "1234567890", user_type: "tasker",
        confirm_token: "112ewqee2123wqwqw12wq", image_url: cloudinary_img_url,
        latitude: "-1.297849", longitude: "36.7868873", confirmed: true,
        has_taken_quiz: true
      },
      {
        firstname: "Austin", lastname: "Powers",
        email: "austin.powers@andela.com", street_address: "530, Muranga Road",
        city: "Muranga", state: "Central", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq",
        image_url: cloudinary_img_url,
        latitude: "-1.0385092", longitude: "37.0755163"
      },
      {
        firstname: "Robert", lastname: "Alai",
        email: "robert.alai@andela.com", street_address: "3, Kitale",
        city: "Kitale", state: "Busia", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq",
        image_url: cloudinary_img_url,
        latitude: "1.0187148", longitude: "34.9920014"
      },
      {
        firstname: "Jill", lastname: "Scott",
        email: "jill.scott@andela.com", street_address: "Adams Arcade",
        city: "Kileleshwa", state: "Kiambu", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq",
        image_url: cloudinary_img_url,
        latitude: "-1.2999473", longitude: "36.7809143"
      }
    ]
  end

  def tasks_list
    [
      { name: "Carpentry" },
      { name: "Plate Washing" },
      { name: "Laundry" },
      { name: "Ironing" },
      { name: "Cleaning" },
      { name: "Cook" }
    ]
  end

  def skillsets
    [
      { user_id: 1, task_id: 1 },
      { user_id: 1, task_id: 4 },
      { user_id: 2, task_id: 5 },
      { user_id: 3, task_id: 6 },
      { user_id: 4, task_id: 5 },
      { user_id: 5, task_id: 3 },
      { user_id: 3, task_id: 1 },
      { user_id: 2, task_id: 4 },
      { user_id: 5, task_id: 2 },
      { user_id: 8, task_id: 6 },
      { user_id: 7, task_id: 5 },
      { user_id: 8, task_id: 3 },
      { user_id: 9, task_id: 2 }
    ]
  end

  def user_plan
    [
      { user_id: 3, name: "novice" },
      { user_id: 2, name: "novice" }
    ]
  end

  def biddings
    Bidding.create(
      tasker_id: User.where(firstname: "Olaide").first.id,
      name: Faker::Lorem.word,
      description: Faker::Lorem.sentence(5),
      price_range: Faker::Number.number(4)
    )
  end

  def create_all
    User.destroy_all
    Task.destroy_all
    Skillset.destroy_all
    UserPlan.destroy_all
    Bidding.destroy_all
    users_list.each { |user| User.create(user) }
    tasks_list.each { |task| Task.create(task) }
    skillsets.each { |skill| Skillset.create(skill) }
    user_plan.each { |user| UserPlan.create(user) }
    10.times { biddings }
  end

  def add_skillset_name
    skillsets = %w(Capentry Pluming Electrician Cleaner)
    Skillset.all[-4..-1].each { |skillset| skillset.name = skillsets.sample }
  end
end
workdey_data = SeedData.new
workdey_data.create_all
workdey_data.add_skillset_name
