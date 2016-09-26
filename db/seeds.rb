class SeedData
  def users_list
    cloudinary_img_url =
      "http://res.cloudinary.com/dxoydowjy/image/upload/v1452076402/"\
    "rxxvqznd6ayvqlmxoon2.png"
    admin_img_url=
    [
      { firstname: "Super", lastname: "Man",
        email: "morris.kimani@andela.com", street_address: nil,
        city: "Nairobi", state: nil, password: "1234567890",
        user_type: "admin", confirm_token: "112ewqee2123wqwqw12wq",
        confirmed: true
      },
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

  def skillsets
    [
      { name: "Carpentry" },
      { name: "Electrician" },
      { name: "Plumbing" },
      { name: "Cleaning" }
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
    Skillset.destroy_all
    UserPlan.destroy_all
    Bidding.destroy_all
    TaskeeSkillset.destroy_all
    users_list.each { |user| User.create(user) }
    skillsets.each { |skill| Skillset.create(skill) }
    user_plan.each { |user| UserPlan.create(user) }
    taskee_skillsets.each { |tas_skillset| TaskeeSkillset.create(tas_skillset) }
    10.times { biddings }
  end

  def taskee_skillsets
    [
      { taskee_id: 1, skillset_id: 1 },
      { taskee_id: 1, skillset_id: 2 },
      { taskee_id: 4, skillset_id: 4 },
      { taskee_id: 1, skillset_id: 3 },
      { taskee_id: 6, skillset_id: 1 },
      { taskee_id: 7, skillset_id: 4 },
      { taskee_id: 7, skillset_id: 3 },
      { taskee_id: 8, skillset_id: 3 }
    ]
  end
end
workdey_data = SeedData.new
workdey_data.create_all
