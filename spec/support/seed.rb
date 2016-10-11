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
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq" },
      { firstname: "Ben", lastname: "Kanyolo",
        email: "bernard.kanyolo+workdey1@andela.com", street_address: "34, Adeyemo Alakija",
        city: "VI", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq" }
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

  def questions
    [
      {
        question: "Which of the following skills are you proficient in? Pick all that apply.",
        required: true,
        options: [
          "Plumbing",
          "Electrical",
          "Carpenting",
          "House Cleaning",
          "Other"
          ]
      },

      {
        question: "What services do you offer in your skill of specialization?",
        required: true,
        options: []
      },

      {
        question: "How long have you practised your skill of specialization?",
        required: true,
        options: []
      },

      {
        question: "What do you love about your work?",
        required: true,
        options: []
      },

      {
        question: "Why do you want to join WorkDey?",
        required: true,
        options: []
      },

      {
        question: "What training or certification have you received? Where did you receive it?",
        required: true,
        options: []
      },

      {
        question: "Which methods of communication are you comfortable with?",
        required: true,
        options: [
          "Email",
          "SMS",
          "Phone Call",
          "Smart Phone",
          "Other"
          ]
      },

      {
        question: "What is your biggest weakness and how do you plan to overcome it?",
        required: false,
        options: []
      },

      {
        question: "What challenge have you faced at work and how did you deal with it?",
        required: false,
        options: []
      },

      {
        question: "Where do you see yourself in 5 years?",
        required: false,
        options: []
      }
    ]
  end

  def create_all
    users_list.each { |user| User.create(user) }
    tasks_list.each { |task| Task.create(task) }
    skillsets.each { |skill| Skillset.create(skill) }
    questions.each { |question| Question.create(question) }
  end
end
