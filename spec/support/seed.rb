# frozen_string_literal: true
class Seed
  def users_list
    [
      { firstname: "Olaide", lastname: "Ojewale",
        email: "olaide.ojewale@andela.com", street_address: "55 Moleye Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq",
        confirmed: true, has_taken_quiz: true },
      { firstname: "Chinedu", lastname: "Daniel",
        email: "chinedu.daniel@andela.com", street_address: "55 Moleye Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq",
        has_taken_quiz: true, confirmed: true },
      { firstname: "Temitope", lastname: "Amodu",
        email: "temitope.amodu@andela.com", street_address: "2 Funso Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "tasker", confirmed: true,
        confirm_token: "112ewqee2123wqwqw12wq" },
      { firstname: "Ruth", lastname: "Chukwumam",
        email: "ruth.chukwumam@andela.com", street_address: "44 Isaac John",
        city: "GRA", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq" },
      { firstname: "Chinedu", lastname: "Dan",
        email: "chinedu.dan@andela.com", street_address: "34, Adeyemo Alakija",
        city: "VI", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq" }
    ]
  end

  def create_all
    users_list.each { |user| User.create(user) }
  end
end
