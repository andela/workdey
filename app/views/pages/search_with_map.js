function getMap() {
        console.log("this method is called")
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(initMap);
        } else {
            x.innerHTML = "Geolocation is not supported by this browser.";
        }
    };

    var position;

    var map;
    function initMap(current_position) {
      position = {lat: current_position.coords.latitude, lng: current_position.coords.longitude};
        console.log(position)
      map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: position.lat, lng: position.lng},
        zoom: 14
      });

        var marker = new google.maps.Marker({
            position: position,
            map: map,
            title: 'Your current Location! '
          });
        }

        markers = []
            function setMarker() {
                i = 9
                var going = {lat: 6.5083701, lng: 3.3842473}
                console.log("button clicked")
                        var karashika = new google.maps.Marker({
                        position: going,
                        map: map,
                        title: ' New Marker Location! '
                      });
                // while (i > 0) {
                //     var lat = position.lat + (i * 0.1);
                //     var lng = position.lng + (i * 0.1);
                //     var newMarker = new google.maps.Marker({
                //         position: {lat: lat, lng: lng}
                //         });
                //     newMarker.setMap(map)
                //     markers.push(newMarker)
                //     i -= 1;
                };
    //     function showPosition(position) {
    //         handler = Gmaps.build('Google');
    //         handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    //           markers = handler.addMarkers([
    //             {
    //               "lat": position.coords.latitude ,
    //               "lng": position.coords.longitude,
    //               "picture": {
    //                 "url": "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png",
    //                 "width":  32,
    //                 "height": 32
    //               },
    //               "infowindow": "hello!"
    //             }
    //           ]);
    //           handler.bounds.extendWith(markers);
    //           handler.fitMapToBounds();
    //         });
    //      console.log ('this map has loaded')
    //     };


