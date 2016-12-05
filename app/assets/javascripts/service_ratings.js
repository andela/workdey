// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$("document").ready(function () {
  $("#service-rating").rateYo({fullStar: true, starWidth: "50px"});

  $("#service-rating").rateYo().on("rateyo.set", function (e, data) {
      $("#service_rating_rating").val(data.rating);
  });

  $("#service-rating-view").rateYo({
    fullStar: true,
    starWidth: "50px",
    readOnly: true,
    rating: parseInt($("#service_rating_rating").val())
  });

  $("#average-service-rating").rateYo({
    fullStar: false,
    starWidth: "50px",
    readOnly: true,
    rating: parseFloat($("#average-rating").text())
  });
});
