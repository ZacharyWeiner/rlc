//= require locations/js/jquery-2.2.1.min
//= require locations/js/jquery-migrate-1.2.1.min
//= require jquery_ujs
// require jquery-ui/widgets/autocomplete
// require autocomplete-rails
//= require locations/js/jquery.plugin.min
//= require locations/js/jquery.countdown.min

//= require locations/js/bootstrap.min
//= require locations/js/bootstrap-select.min
//= require locations/js/richmarker-compiled.js
//= require locations/js/jquery.validate.min
//= require locations/js/jquery.fitvids
//= require locations/js/moment.js
//= require locations/js/bootstrap-datetimepicker.min
//= require locations/js/icheck.min
//= require locations/js/owl.carousel.min
//= require locations/js/jquery.trackpad-scroll-emulator.min
//= require locations/js/jQuery.MultiFile.min
//= require locations/js/jquery.nouislider.all.min
//= require locations/js/infobox
//= require locations/js/jssocials.min
//= require locations/js/markerclusterer_packed
//= require locations/js/masonry.pkgd.min
//= require locations/js/readmore.min
//= require locations/custom
//= require locations/js/maps

// function initMap() {
//         var map = new google.maps.Map(document.getElementById('map'), {
//           center: {lat: 40.471732, lng: -106.826383},
//           zoom: 14
//         });
//         var card = document.getElementById('pac-card');
//         var input = document.getElementById('pac-input');
//         var types = document.getElementById('type-selector');
//         var strictBounds = document.getElementById('strict-bounds-selector');

//         map.controls[google.maps.ControlPosition.TOP_RIGHT].push(card);

//         var autocomplete = new google.maps.places.Autocomplete(input);

//         // Bind the map's bounds (viewport) property to the autocomplete object,
//         // so that the autocomplete requests use the current map bounds for the
//         // bounds option in the request.
//         autocomplete.bindTo('bounds', map);

//         var infowindow = new google.maps.InfoWindow();
//         var infowindowContent = document.getElementById('infowindow-content');
//         infowindow.setContent(infowindowContent);
//         var marker = new google.maps.Marker({
//           map: map,
//           anchorPoint: new google.maps.Point(0, 0)
//         });

//         autocomplete.addListener('place_changed', function() {
//           infowindow.close();
//           marker.setVisible(false);
//           var place = autocomplete.getPlace();
//           if (!place.geometry) {
//             // User entered the name of a Place that was not suggested and
//             // pressed the Enter key, or the Place Details request failed.
//             window.alert("No details available for input: '" + place.name + "'");
//             return;
//           }

//           // If the place has a geometry, then present it on a map.
//           if (place.geometry.viewport) {
//             map.fitBounds(place.geometry.viewport);
//           } else {
//             map.setCenter(place.geometry.location);
//             map.setZoom(17);  // Why 17? Because it looks good.
//           }
//           marker.setPosition(place.geometry.location);
//           marker.setVisible(true);

//           var address = '';
//           if (place.address_components) {
//             address = [
//               (place.address_components[0] && place.address_components[0].short_name || ''),
//               (place.address_components[1] && place.address_components[1].short_name || ''),
//               (place.address_components[2] && place.address_components[2].short_name || '')
//             ].join(' ');
//           }

//           infowindowContent.children['place-icon'].src = place.icon;
//           infowindowContent.children['place-name'].textContent = place.name;
//           infowindowContent.children['place-address'].textContent = address;
//           infowindow.open(map, marker);
//         });

//         // Sets a listener on a radio button to change the filter type on Places
//         // Autocomplete.
//         function setupClickListener(id, types) {
//           var radioButton = document.getElementById(id);
//           radioButton.addEventListener('click', function() {
//             autocomplete.setTypes(types);
//           });
//         }

//         setupClickListener('changetype-all', []);
//         setupClickListener('changetype-address', ['address']);
//         setupClickListener('changetype-establishment', ['establishment']);
//         setupClickListener('changetype-geocode', ['geocode']);

//         document.getElementById('use-strict-bounds')
//             .addEventListener('click', function() {
//               console.log('Checkbox clicked! New state=' + this.checked);
//               autocomplete.setOptions({strictBounds: this.checked});
//             });
//       }

 function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    mapTypeControl: false,
    center: {lat: 40.471732, lng: -106.826383},
    zoom: 13
  });

  new AutocompleteDirectionsHandler(map);
}

 /**
  * @constructor
 */
function AutocompleteDirectionsHandler(map) {
  this.map = map;
  this.originPlaceId = null;
  this.destinationPlaceId = null;
  this.travelMode = 'DRIVING';
  var originInput = document.getElementById('origin-input');
  var destinationInput = document.getElementById('destination-input');
  var modeSelector = document.getElementById('mode-selector');
  this.directionsService = new google.maps.DirectionsService;
  this.directionsDisplay = new google.maps.DirectionsRenderer;
  this.directionsDisplay.setMap(map);

  var originAutocomplete = new google.maps.places.Autocomplete(
      originInput, {placeIdOnly: true});
  var destinationAutocomplete = new google.maps.places.Autocomplete(
      destinationInput, {placeIdOnly: true});

  this.setupPlaceChangedListener(originAutocomplete, 'ORIG');
  this.setupPlaceChangedListener(destinationAutocomplete, 'DEST');

  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(originInput);
  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(destinationInput);
  this.map.controls[google.maps.ControlPosition.TOP_LEFT].push(modeSelector);
}

// Sets a listener on a radio button to change the filter type on Places
// Autocomplete.
AutocompleteDirectionsHandler.prototype.setupClickListener = function(id, mode) {
  var radioButton = document.getElementById(id);
  var me = this;
  radioButton.addEventListener('click', function() {
    me.travelMode = mode;
    me.route();
  });
};

AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(autocomplete, mode) {
  var me = this;
  autocomplete.bindTo('bounds', this.map);
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.place_id) {
      window.alert("Please select an option from the dropdown list.");
      return;
    }
    if (mode === 'ORIG') {
      me.originPlaceId = place.place_id;
    } else {
      me.destinationPlaceId = place.place_id;
    }
    me.route();
  });

};

AutocompleteDirectionsHandler.prototype.route = function() {
  if (!this.originPlaceId || !this.destinationPlaceId) {
    return;
  }
  var me = this;

  this.directionsService.route({
    origin: {'placeId': this.originPlaceId},
    destination: {'placeId': this.destinationPlaceId},
    travelMode: this.travelMode
  }, function(response, status) {
    if (status === 'OK') {
      me.directionsDisplay.setDirections(response);
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });
};
