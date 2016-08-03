$(function (){
  var minPrice = $('#min_price'),
    maxPrice = $('#max_price')

  $('#min_price, #max_price').on('blur', function () {
    if (maxPrice.val() !== "") {
      if (Number(minPrice.val()) > Number(maxPrice.val())) {
        $('#min_price, #max_price').addClass('invalid')
        Materialize.toast('Minimum price can\'t be greater than maximum price', 4000)
      } else {
        $('#min_price, #max_price').removeClass('invalid')
      }
    } else {
      $('#min_price').removeClass('invalid')
    }
  })
})
