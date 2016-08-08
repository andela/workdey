 var modal_object = function(object, id){
  $("span#name").html(object.firstname+ " "+ object.lastname);
  $("span#phone").html(object.phone);
  $("span#email").html(object.email);
  
  $.get( "/dashboard/notifications/"+ id, function( data ) {
    console.log(data);
  });
  $("#modal1").openModal();
}
