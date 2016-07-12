module ApplicationControllerSpecHelper
  def stub_current_user(user)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)
  end
end
