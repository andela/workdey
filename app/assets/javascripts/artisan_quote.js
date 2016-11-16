function artisan_quote_input(){
  var quote_input = "<div class='quote-value-input'>\
                      <hr>\
                      <p>Name your price</p>\
                      <input id='quote_value' type='number'\
                       placeholder='Enter your quote'>\
                       <div id='quote_value_error'></div>\
                      <button id='send-quote' class='btn waves-effect waves-light teal'>\
                        Send Quote\
                      </button>\
                    <div>"
  return quote_input;
}

function quoted_value(){
  return document.getElementById('quote_value').value;
}

function is_quoted_value_empty(){
  return quoted_value() == '';
}

function quoted_value_is_zero_or_negative(){
  return quoted_value() <= 0;
}

function quoted_value_has_non_numeric_characters(){
  return !(/^\d+$/.test(quoted_value()));
}

function send_quote(service_id){
  $.ajax({
      url: ('/quotes'),
      method: "POST",
      data: { service_id: service_id, quoted_value: quoted_value() }
    });
}
