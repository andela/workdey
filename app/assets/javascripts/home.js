 // $(document).ready( function() {
 //     $('').on('click', slideonlyone('sms_box'));
 // });
function getLocation() {
  console.log("this method is being called")
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(saveCordinates);
    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}



function saveCordinates(position) {
  console.log("method called")
  $.ajax({
    type: "POST",
    url: "/dashboard/update_location",
    data: { longitude: position.coords.longitude, latitude: position.coords.latitude},
    success: function(data){
      alert("success")
      return false;
    },
    error: function(data){
      return false;
    }
  });
}



// function saveCordinates(position) {
//   console.log("method called")
//   $.ajax({
//     type: "POST",
//     url: "/dashboard/update_location",
//     data: { longitude: position.coords.longitude, latitude: position.coords.latitude},
//     success:(data) => {
//       alert("success");
//       return false },
//     error:(data) => {
//       return false
//     }
//   };
// })
