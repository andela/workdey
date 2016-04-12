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
        image_url: cloudinary_img_url
      },
      { firstname: "Chinedu", lastname: "Daniel",
        email: "chinedu.daniel@andela.com", street_address: "55 Moleye Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "tasker", confirmed: true,
        confirm_token: "112ewqee2123wqwqw12wq",
        image_url: cloudinary_img_url
      },
      { firstname: "Temitope", lastname: "Amodu",
        email: "temitope.amodu@andela.com", street_address: "2 Funso Street",
        city: "Yaba", state: "Lagos", password: "1234567890",
        user_type: "tasker", confirmed: true,
        confirm_token: "112ewqee2123wqwqw12wq",
        image_url: cloudinary_img_url
      },
      { firstname: "Ruth", lastname: "Chukwumam",
        email: "ruth.chukwumam@andela.com", street_address: "44 Isaac John",
        city: "GRA", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq",
        confirmed: true, has_taken_quiz: true, image_url: cloudinary_img_url
      },
      { firstname: "Chinedu", lastname: "Dan",
        email: "chinedu.dan@andela.com", street_address: "34, Adeyemo Alakija",
        city: "VI", state: "Lagos", password: "1234567890",
        user_type: "taskee", confirm_token: "112ewqee2123wqwqw12wq",
        image_url: cloudinary_img_url
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
      { user_id: 1, task_id: 1 }
    ]
  end

  def user_plan
    [
      { user_id: 3, name: "novice" },
      { user_id: 2, name: "novice" }
    ]
  end

  def create_all
    User.destroy_all
    Task.destroy_all
    Skillset.destroy_all
    UserPlan.destroy_all
    users_list.each { |user| User.create(user) }
    tasks_list.each { |task| Task.create(task) }
    skillsets.each { |skill| Skillset.create(skill) }
    user_plan.each { |user| UserPlan.create(user) }
  end
end
workdey_data = SeedData.new
workdey_data.create_all
