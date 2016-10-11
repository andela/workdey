var dispatcher = new WebSocketRails(host_name())
var map
var markers = []

function host_name () {
  if ( location.port.length === 0 ) {
    return location.hostname + '/websocket'
  } else {
    return location.hostname + ':' + location.port + '/websocket'
  }
}

var locationController = {
  getPosition: function () {
    return {
      longitude: $('#marker-location').attr('data-longitude'),
      latitude: $('#marker-location').attr('data-latitude')
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
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    maxZoom: 17
  }

  map = new google.maps.Map(document.getElementById('map'), mapOptions)


  var marker = new google.maps.Marker({
    position: position,
    map: map,
		icon: {
			path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW,
			scale: 6
		}
  })

  var infoWindow = new google.maps.InfoWindow({
    content: '<h5>You are here!</h5>'
  })

  infoWindow.open(map, marker)

  marker.addListener('click', function () {
    infoWindow.open(map, marker)
  })

  this.createArtisansMarkers()
}

navigatorController.markerInfo = function (artisan) {
  var phone = artisan.phone || 'n/a'

  var infoString = [
    '<section style="width: 400px; text-align: initial"><div class="row"><div class="col s4">',
    '<img src="' + artisan.avatar + '" alt="' + artisan.name + '" width="50px" height="50px" style="border-radius: 100%">',
    '</div><div class="col s8">',
    '<h4>' + artisan.name + '</h4>',
    '</div></div><div class="row"><div class="col s6">',
    '<i class="material-icons">phone</i> ' + phone + '',
    '</div><div class="col s6">',
    '<b>Joined: </b>' + moment(artisan.joined, 'YYYYMMDD').fromNow() + '',
    '</div></div><div class="row"><div class="col s12">',
    '<i class="material-icons">room</i> ' + artisan.location + '',
    '</div></div><div class="row">',
    '<div class="col s12">',
    '<a class="btn" href="' + artisan.link + '">View</a>',
    '</div></div></section>',
  ].join('')

  var infoWindow = new google.maps.InfoWindow({
    content: infoString
  })

  return infoWindow
}

navigatorController.createMarkers = function (artisans) {
  var bounds = new google.maps.LatLngBounds()
  clearMarkers(markers)
  markers = []
  artisans.map(function (artisan) {
    if (artisan.distance <= 50) {
      var m = new google.maps.Marker({
        position: {
          lat: artisan.coords[0],
          lng: artisan.coords[1]
        }
      })
      markers.push({
        marker: m,
        artisan: artisan
      })
      bounds.extend(m.getPosition())
      map.fitBounds(bounds)
    }
  })
  navigatorController.addMarkers()
}

navigatorController.createArtisansMarkers = function () {
  dispatcher.trigger('artisans.get_nearby_artisans')
  dispatcher.bind('artisans.success', function (artisan) {
    var artisans = JSON.parse(artisan)
    var tasks = navigatorController.getTasks(artisans)
    navigatorController.createSelect(tasks)
    navigatorController.createMarkers(artisans)
  })
}

navigatorController.addMarkers = function () {
  markers.map(function (marker) {
    marker.marker.setMap(map)
    marker.marker.addListener('click', function () {
      navigatorController.markerInfo(marker.artisan).open(map, marker.marker)
    })
  })
}

navigatorController.getTasks = function (artisans) {
  var tasks = []
  artisans.map(function (artisan) {
    if (artisan.distance <= 50){
      tasks.push(artisan.tasks)
    }
  })
  var result = tasks.reduce(function (a, b) {
    return a.concat(b)
  }).filter(function (itm, i, a) {
    return i === a.indexOf(itm)
  })
  return result
}

navigatorController.createSelect = function (tasks) {
  var searchSelect = $('#select_task')
  searchSelect.empty()
  $.each(tasks, function (index, value) {
    searchSelect.append($('<option></option>').attr('value', value).text(value))
  })
}

navigatorController.geolocate = function () {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function success (pos) {
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

$('#select_task').change(function () {
  dispatcher.trigger('search_artisan.search_by_task', this.value)
  dispatcher.bind('search_artisan.success', function (artisan) {
    var artisans = JSON.parse(artisan)
    navigatorController.createMarkers(artisans)
  })
})

function clearMarkers(markers) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].marker.setMap(null)
  }
}

function reloadMap () {
  $("#reload-map").on('click', function () {
    getLocation()
  })
}

var getLocation = function () {
  navigatorController.getUserPosition()
}

reloadMap()

if (document.getElementById('map')) {
  loadScript('<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBiKS5l5Gh-4OeQS7HFY5-ps60Iz5YB-0s&callback=getLocation" async defer></script>')
}
