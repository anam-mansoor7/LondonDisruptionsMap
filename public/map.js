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
});