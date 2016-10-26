$('.modal-trigger').leanModal();
  function modal_object(object, id){
   $("span#name").html(object.firstname+ " "+ object.lastname);
   $("span#phone").html(object.phone);
   $("span#email").html(object.email);

   $.get( "/dashboard/notifications/"+ id);
 }
