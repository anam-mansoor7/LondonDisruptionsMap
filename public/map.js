$(document).ready(function() {
  var myLatlng = new google.maps.LatLng(51.528837, -0.165653);
  var myOptions = {
    zoom: 10,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    mapTypeControl: false,
    streetViewControl: false,
    panControl: false,
    zoomControlOptions: {
    position: google.maps.ControlPosition.LEFT_BOTTOM
    }
  }

  var map = new google.maps.Map($("#map")[0], myOptions);
  var bounds = new google.maps.LatLngBounds();
    var locations = [
  ['Bondi Beach', -33.890542, 151.274856, 4],
  ['Coogee Beach', -33.923036, 151.259052, 5],
  ['Cronulla Beach', -34.028249, 151.157507, 3],
  ['Manly Beach', -33.80010128657071, 151.28747820854187, 2],
  ['Maroubra Beach', -33.950198, 151.259302, 1]
	];
	draw_markers(locations);

  function draw_markers(locations){
    var infowindow = new google.maps.InfoWindow({
      maxWidth: 160
    });

  	var markers = new Array();
        
    for (var i = 0; i < locations.length; i++) {  
      var marker = new google.maps.Marker({
        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
        map: map,
      });

      markers.push(marker);

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent(locations[i][0]);
          infowindow.open(map, marker);
        }
      })(marker, i));
    }
    auto_center(markers);
  }

  function auto_center(markers) {
    //  Go through each...
    for (var i = 0; i < markers.length; i++) {  
      bounds.extend(markers[i].position);
    }
    //  Fit these bounds to the map
    map.fitBounds(bounds);
  }
});