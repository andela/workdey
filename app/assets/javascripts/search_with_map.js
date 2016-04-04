function getLocation (func) {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function success (pos) {
        func === 'save' ? saveCordinates(pos) : initMap(pos)
      },
      function error (err) {
        console.warn('ERROR(' + err.code + '): ' + err.message)
      },
      {
        enableHighAccuracy: true
      }
    )
  } else {
    window.alert('Geolocation is not supported by this browser.')
  }
}

function loadScript (src) {
  var script = document.createElement('script')
  document.getElementsByTagName('body')[0].appendChild(script)
  script.src = src
}

function initMap (pos) {
  position = new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude)
  var mapOptions = {
    zoom: 12,
    center: position,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  map = new google.maps.Map(document.getElementById('map'), mapOptions)

  marker = new google.maps.Marker({
    position: position,
    map: map
  })
}

function saveCordinates (pos) {
  console.table([
    { coord: pos.coords.longitude },
    { coord: pos.coords.latitude }
  ])

  // save coordinates.
  $.post('/dashboard/update_location',
    {
      longitude: pos.coords.longitude,
      latitude: pos.coords.latitude
    },
    function (data, textStatus, jqXHR) {
      console.log(data)
    }
  )
}

$('#tag-location').click(function () {
  getLocation('save')
})

loadScript('https://maps.googleapis.com/maps/api/js?key=AIzaSyBiKS5l5Gh-4OeQS7HFY5-ps60Iz5YB-0s&callback=getLocation')
