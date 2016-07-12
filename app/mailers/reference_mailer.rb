class ReferenceMailer < ApplicationMailer
  def reference_email(reference)
    @reference = reference
    mail to: @reference.email, subject: "Reference Request"
  end
end
