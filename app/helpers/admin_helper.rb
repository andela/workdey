module AdminHelper
  def strptime(time)
    Date.strptime(time.to_s, "%Y-%m-%d")
  end
end
