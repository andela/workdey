var locationController = {
  btn: function () {
    return $('#tag-location')
  },
  getPosition: function () {
    return {
      longitude: this.btn().attr('data-longitude'),
      latitude: this.btn().attr('data-latitude')
    }
  },
  hasCoords: function () {
    return this.getPosition().longitude !== '' && this.getPosition().latitude !== ''
  }
}

var navigatorController = Object.create(locationController)

navigatorController.getUserPosition = function () {
  var pos = this.getPosition()
  var coord = this.hasCoords()

  if (coord) {
    return this.initMap({
      coords: {
        longitude: pos.longitude,
        latitude: pos.latitude
      }
    })
  } else {
    return this.geolocate()
  }
}

navigatorController.initMap = function (pos) {
  var position = new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude)
  var mapOptions = {
    zoom: 12,
    center: position,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  var map = new google.maps.Map(document.getElementById('map'), mapOptions)

  var marker = new google.maps.Marker({
    position: position,
    map: map
  })

  marker.addListener('click', function () {
    navigatorController.markerInfo().open(map, marker)
  })

  this.createMarkers(map)
}

navigatorController.markerInfo = function () {
  var infoString = "<h1>lorem ipsum</h1>"

  var infoWindow = new google.maps.InfoWindow({
    content: infoString
  })

  return infoWindow
}

navigatorController.createMarkers = function (map) {
  var markers = []
  var bounds = new google.maps.LatLngBounds()

  for (var i = 0, len = 20; i < len; i++) {
    var m = new google.maps.Marker({
      position: {
        lat: Math.random() * (-1.3 - -1.2) + -1.2,
        lng: Math.random() * (36.7889 - 36.5) + 36.5
      },
      map: map
    })
    markers.push(m)
    bounds.extend(m.getPosition())
  }

  map.fitBounds(bounds)

  markers.map(function (marker) {
    marker.addListener('click', function () {
      navigatorController.markerInfo().open(map, marker)
    })
  })
}

navigatorController.geolocate = function () {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function success (pos) {
        navigatorController.saveCordinates(pos)
        navigatorController.initMap(pos)
      },
      function error (err) {
        window.alert('ERROR(' + err.code + '): ' + err.message)
      },
      {
        enableHighAccuracy: true
      }
    )
  } else {
    window.alert('Geolocation is not supported by this browser.')
  }
}

navigatorController.saveCordinates = function (pos) {
  $.post('/dashboard/update_location',
    {
      longitude: pos.coords.longitude,
      latitude: pos.coords.latitude
    },
    function (data, textStatus, jqXHR) {
      console.log(textStatus)
    }
  )
}

navigatorController.handleClick = function () {
  var btn = this.btn()

  btn.on('click', function () {
    navigatorController.geolocate()
  })
}

navigatorController.handleClick()

function loadScript (src) {
  var script = document.createElement('script')
  document.getElementsByTagName('body')[0].appendChild(script)
  script.src = src
}

var getLocation = function () {
  navigatorController.getUserPosition()
}

if (document.getElementById('map')) {
  loadScript('https://maps.googleapis.com/maps/api/js?key=AIzaSyBiKS5l5Gh-4OeQS7HFY5-ps60Iz5YB-0s&callback=getLocation')
}
