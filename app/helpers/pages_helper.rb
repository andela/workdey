module PagesHelper
  def text_tags(name, value = "", holder = "", class_name = "", req = false)
    text_field_tag name, value, placeholder: holder, class: class_name,
                                required: req
  end

  def email_tags(name, value = "", holder = "", class_name = "", req = false)
    email_field_tag name, value, placeholder: holder,
                                 class: class_name, required: req,
                                 pattern: email_validator
  end
end
