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
  }

  function draw_polygon(effected_areas){
    var polygons = [];
    for (var i = 0; i < effected_areas.length; i++) {
      arr = [];
      var effected_area = effected_areas[i];
      for (var j=0; j < effected_area.length; j = j+2) {
        arr.push( new google.maps.LatLng(effected_area[j], effected_area[j+1]));
        // console.log(effected_area[j])
        // console.log(effected_area[j+1])
        bounds.extend(arr[arr.length-1])
      }
      polygons.push(new google.maps.Polygon({
        paths: arr,
        strokeColor: '#FF0000',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#FF0000',
        fillOpacity: 0.35
      }));
      polygons[polygons.length-1].setMap(map);
    }
    map.fitBounds(bounds);
  }

  var get_disruptions_data = function() {
    $.ajax({
      type: 'GET',
      url: 'http://localhost:9292/get_disruptions',
      crossDomain: true,
      data: '',
      dataType: "json",
      success: function(responseData, textStatus, jqXHR) {
        // console.log('POST success.' + responseData['disruption_points']);
        draw_markers(responseData['disruption_points'])
        draw_polygon(responseData['effected_areas'])
      },
      error: function (responseData, textStatus, errorThrown) {
        // console.log('POST failed.' + textStatus);
      }
    })
  ;};

  get_disruptions_data();
  var interval = 1000 * 60 * 5; 
  setInterval(get_disruptions_data, interval);
});