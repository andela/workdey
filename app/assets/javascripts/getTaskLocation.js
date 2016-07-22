(function() {
  var theMap = document.getElementById('location-map'),
    geoKeyServer = 'AIzaSyCRQxMsW_MlAgLHcLfusmE0w0JffQYZc8I',
    geoKeyBrowser = 'AIzaSyAciD9tqawo-_mno8ALOgvRHlFLx9o_i3c',
    markers = [],
    map

  // Main function Get user location and initializes the map
  function initLocationMap () {
    if (!navigator.geolocation) {
      window.alert('Geolocation not supported by this browser')
    }

    // User browser support getting location
    function success (pos) {
      var lat = pos.coords.latitude
      var lng = pos.coords.longitude
      var mapCenter = { lat: lat, lng: lng }

      map = new google.maps.Map(theMap, {
        zoom: 15,
        center: mapCenter
      })

      addMarker(map, mapCenter)

      // set the coordinates
      $('#task_latitude').val(mapCenter.lat)
      $('#task_longitude').val(mapCenter.lng)

      var geocoder = new google.maps.Geocoder()

      getFormatedAddress(mapCenter)

      document.getElementById('task_location').addEventListener('blur', function () {
        geocodeLocation(geocoder, map)
      })
    }

    // Get formatted address from current user location
    function getFormatedAddress (pos) {
      var lat = pos.lat,
        lng = pos.lng
      $.get('https://maps.googleapis.com/maps/api/geocode/json?latlng=' + lat + ',' + lng + '&key=' + geoKeyServer, function (data) {
        $('.location > label').addClass('active')
        $('#task_location').val(data.results[0].formatted_address)
      })
    }

    // Get formatted address from user location input when creating tasks
    function geocodeLocation (geocoder, resultsMap) {
      var location = document.getElementById('task_location').value
      geocoder.geocode({'address': location}, function (results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
          var loc = results[0].geometry.location

          // set the coordinates
          $('#task_latitude').val(loc.lat())
          $('#task_longitude').val(loc.lng())

          clearMarkers()
          resultsMap.setCenter(loc)
          addMarker(resultsMap, loc)
        } else if (status === google.maps.GeocoderStatus.ZERO_RESULTS) {
          swal({
            title: 'Location not found!',
            text: 'The location couldn\'t be found.',
            type: 'error',
            confirmButtonColor: '#eb4d5c'
          })
        }
      })
    }

    // Adds a marker to the map and push to the array.
    function addMarker(map, location) {
      var marker = new google.maps.Marker({
        position: location,
        map: map
      })
      markers.push(marker)
    }

    // remove markers from the map
    function clearMarkers () {
      for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null)
      }
      markers = []
    }

    // handle navigator error
    function error () {
      swal('Location error', 'Unable to retrieve your location.', 'error')
    }

    navigator.geolocation.getCurrentPosition(success, error)
  }

  // get static map
  function getStaticMap () {
    var mapcenter = $('.map-center').text(),
      maplat = $('.map-latitude').text(),
      maplng = $('.map-longitude').text(),
      mapWidth = 1200,
      mapHeight = 300,
      mapURI = 'https://maps.googleapis.com/maps/api/staticmap'

    var src = mapURI + '?center=' + encodeURI(mapcenter) + '&scale=2&zoom=14&size=' + mapWidth + 'x' + mapHeight +
      '&visual_refresh=true&markers=size:mid%7Ccolor:0xff0000%7Clabel:%7C' + encodeURI(mapcenter) + '&key=' + geoKeyBrowser

    $('#task_location_map > img').fadeIn('slow', function () {
      $(this).removeClass('hide')
      $(this).attr('src', src)
    })
  }

  if (document.getElementById('task_location_map')) {
    getStaticMap()
  }

  if (document.getElementById('location-map')) {
    loadScript('<script src="https://maps.googleapis.com/maps/api/js?key=' + geoKeyBrowser + '&callback=initLocationMap" async defer></script>')
  }
}());
