class RegretMailer < ApplicationMailer
	def regret_email(user, body)
		@user = user
		@body = body
		mail(to: @user.email, subject: "Job Offer #{user.firstname}")
	end
end
