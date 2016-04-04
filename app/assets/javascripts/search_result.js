function geoFindMe() {
  var output = document.getElementById("locator");

  if (!navigator.geolocation) {
    output.innerHTML = "<p>Your browser does not allow us to get your location</p>";
    return;
  }

  function success(position) {
    var latitude  = position.coords.latitude;
    var longitude = position.coords.longitude;

    output.innerHTML = '<p>Your latitude is ' + latitude + '° <br>Your longitude is ' + longitude + '°</p>';
  }

  function error() {
    output.innerHTML = "Unable to retrieve your location";
  }

  output.innerHTML = "<p>Locating…</p>";

  navigator.geolocation.getCurrentPosition(success, error);
}
