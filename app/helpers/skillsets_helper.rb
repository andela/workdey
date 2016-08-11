module SkillsetsHelper
  def skillsets(user)
    all_skillsets = user.skillsets.map(&:name)
    all_skillsets.join(", ")
  end
end
