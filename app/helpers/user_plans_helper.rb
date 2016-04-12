module UserPlansHelper
  def novice?
    user_plan && user_plan.name == "novice"
  end

  def medial?
    user_plan && user_plan.name == "medial"
  end

  def maestro?
    user_plan && user_plan.name == "maestro"
  end
end
