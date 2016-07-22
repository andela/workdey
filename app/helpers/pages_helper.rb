# frozen_string_literal: true
module PagesHelper
  def text_tags(name, value = "", holder = "", class_name = "", req = false,
                disabled = false)
    text_field_tag name, value, placeholder: holder, class: class_name,
                                required: req, disabled: disabled
  end

  def email_tags(name, value = "", holder = "", class_name = "", req = false,
                 disabled = false)
    email_field_tag name, value, placeholder: holder,
                                 class: class_name, required: req,
                                 pattern: email_validator, disabled: disabled
  end
end
