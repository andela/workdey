class Seed
  def users_list
    [
      { firstname: "Olaide", lastname: "Ojewale",
        email: "olaide.ojewale@andela.com", street_address: "55 Moleye Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq"
      },
      { firstname: "Chinedu", lastname: "Daniel",
        email: "chinedu.daniel@andela.com", street_address: "55 Moleye Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq"
      },
      { firstname: "Temitope", lastname: "Amodu",
        email: "temitope.amodu@andela.com", street_address: "2 Funso Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq"
      },
      { firstname: "Ruth", lastname: "Chukwumam",
        email: "ruth.chukwumam@andela.com", street_address: "44 Isaac John",
        city: "GRA", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq"
      },
      { firstname: "Chinedu", lastname: "Dan",
        email: "chinedu.dan@andela.com", street_address: "34, Adeyemo Alakija",
        city: "VI", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq"
      }
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
      { user_id: 1, task_id: 1 },
      { user_id: 1, task_id: 4 },
      { user_id: 2, task_id: 5 },
      { user_id: 3, task_id: 6 },
      { user_id: 4, task_id: 5 },
      { user_id: 5, task_id: 3 },
      { user_id: 3, task_id: 1 },
      { user_id: 2, task_id: 4 },
      { user_id: 5, task_id: 2 },
      { user_id: 1, task_id: 1 }
    ]
  end

  def create_all
    users_list.each { |user| User.create(user) }
    tasks_list.each { |task| Task.create(task) }
    skillsets.each { |skill| Skillset.create(skill) }
  end
end
