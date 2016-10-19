class Seed
  def users_list
    [
      { firstname: "Olaide", lastname: "Ojewale",
        email: "olaide.ojewale@andela.com", street_address: "55 Moleye Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "artisan", confirm_token: "112ewqee2123wqwqw12wq",
        confirmed: true, has_taken_questionnaire: true },
      { firstname: "Chinedu", lastname: "Daniel",
        email: "chinedu.daniel@andela.com", street_address: "55 Moleye Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "artisan", confirm_token: "112ewqee2123wqwqw12wq",
        has_taken_questionnaire: true, confirmed: true },
      { firstname: "Temitope", lastname: "Amodu",
        email: "temitope.amodu@andela.com", street_address: "2 Funso Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "tasker", confirmed: true,
        confirm_token: "112ewqee2123wqwqw12wq" },
      { firstname: "Ruth", lastname: "Chukwumam",
        email: "ruth.chukwumam@andela.com", street_address: "44 Isaac John",
        city: "GRA", state: "Lagos", password: "1234567890",
        user_type: "artisan", confirm_token: "112ewqee2123wqwqw12wq" },
      { firstname: "Chinedu", lastname: "Dan",
        email: "chinedu.dan@andela.com", street_address: "34, Adeyemo Alakija",
        city: "VI", state: "Lagos", password: "1234567890",
        user_type: "artisan", confirm_token: "112ewqee2123wqwqw12wq" },
      { firstname: "Ben", lastname: "Kanyolo",
        email: "bernard.kanyolo+workdey1@andela.com", street_address: "34, Adeyemo Alakija",
        city: "VI", state: "Lagos", password: "1234567890",
        user_type: "artisan", confirm_token: "112ewqee2123wqwqw12wq" }
    ]
  end

  def tasks_list
    [
      { name: "Capentry" },
      { name: "Plate Washing" },
      { name: "Laundry" },
      { name: "Ironing" },
      { name: "Cleaning" },
      { name: "Cook" }
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

  def create_all
    users_list.each { |user| User.create(user) }
    tasks_list.each { |task| Task.create(task) }
    skillsets.each { |skill| Skillset.create(skill) }
  end
end
