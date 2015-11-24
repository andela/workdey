module PagesHelper

  def text_tags(name, value ="", holder ="", class_name ="", required = false)
     text_field_tag name, value, { placeholder: holder, class: class_name, required: required }
  end

  def email_tags(name, value ="", holder ="", class_name ="", required = false)
     email_field_tag name, value, { placeholder: holder, class: class_name, required: required, pattern: email_validator }
  end

end