module UserPlansHelper
  def novice?
    self.user_plan && self.user_plan.name == 'novice'
  end

  def medial?
    self.user_plan && self.user_plan.name == 'medial'
  end

  def maestro?
    self.user_plan && self.user_plan.name == 'maestro'
  end
end
