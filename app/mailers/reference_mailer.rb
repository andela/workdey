class ReferenceMailer < ApplicationMailer
  def reference_email(reference, url)
    @reference = reference
    @url = url
    mail to: @reference.email, subject: "Reference Request"
  end
end
