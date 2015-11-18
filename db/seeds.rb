class SeedData
  def users_list
    [
      { firstname: "Chinedu", lastname: "Daniel",
        email: "chinedu.daniel@andela.com", latitude: "",
        longitude: "", password: "1234567890" },
      { firstname: "Chinedu", lastname: "Daniel",
        email: "chinedu.daniel@andela.com", latitude: "",
        longitude: "", password: "1234567890" },
      { firstname: "Chinedu", lastname: "Daniel",
        email: "chinedu.daniel@andela.com", latitude: "",
        longitude: "", password: "1234567890" },
      { firstname: "Chinedu", lastname: "Daniel", 
        email: "chinedu.daniel@andela.com", latitude: "",
        longitude: "", password: "1234567890" },
      { firstname: "Chinedu", lastname: "Daniel",
        email: "chinedu.daniel@andela.com", latitude: "",
        longitude: "", password: "1234567890" }
    ]
  end

  def tasks_list
    [
      { name: "Capentary" },
      { name: "Plate Washing" },
      { name: "Laundry" },
      { name: "Ironing" },
      { name: "Cleaning" },
      { name: "Cook" }
    ]
  end

  def skillsets
    [
      { user_id: 1, task_id: 1, rate: 2000 },
      { user_id: 1, task_id: 4, rate: 1700 },
      { user_id: 2, task_id: 5, rate: 2000 },
      { user_id: 3, task_id: 6, rate: 800 },
      { user_id: 4, task_id: 5, rate: 1500 },
      { user_id: 5, task_id: 3, rate: 1000 },
      { user_id: 3, task_id: 1, rate: 2500 },
      { user_id: 2, task_id: 4, rate: 2000 },
      { user_id: 5, task_id: 2, rate: 1100 },
      { user_id: 1, task_id: 1, rate: 1200 }
    ]
  end

  def create_all
    User.destroy_all
    Task.destroy_all
    Skillset.destroy_all
    users_list.each { | user | User.create(user) }
    tasks_list.each { | task | Task.create(task) }
    skillsets.each { | skill | Skillset.create(skill) }
  end

end

workdey_data = SeedData.new
workdey_data.create_all
