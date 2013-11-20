// L.LabelOverlay = L.Class.extend({
//     initialize: function(/*LatLng*/ latLng, /*String*/ label, options) {
//         this._latlng = latLng;
//         this._label = label;
//         L.Util.setOptions(this, options);
//     },
//     options: {
//         offset: new L.Point(0, 0)
//     },
//     onAdd: function(map) {
//         this._map = map;
//         if (!this._container) {
//             this._initLayout();
//         }
//         map.getPanes().overlayPane.appendChild(this._container);
//         this._container.innerHTML = this._label;
//         map.on('viewreset', this._reset, this);
//         this._reset();
//     },
//     onRemove: function(map) {
//         map.getPanes().overlayPane.removeChild(this._container);
//         map.off('viewreset', this._reset, this);
//     },
//     _reset: function() {
//         var pos = this._map.latLngToLayerPoint(this._latlng);
//         var op = new L.Point(pos.x + this.options.offset.x, pos.y - this.options.offset.y);
//         L.DomUtil.setPosition(this._container, op);
//     },
//     _initLayout: function() {
//         this._container = L.DomUtil.create('div', 'leaflet-label-overlay');
//     }
// });

window.Hackmap = {

  m: null,
  options: {},
  countries: {
    "Germany": {},
    "France": {},
    "Switzerland": {},
    "Netherlands": {}
  },
  cities: {
    Berlin: {
      country: "Germany",
      lat: -1.294903,
      lng: 36.824005,
      label: '<strong>Berlin</strong>'
    },
    Paris: {
      country: "France",
      lat: 0.312079,
      lng: 32.581276,
      label: '<strong>Paris</strong> 02/10 - 08/10'
    },
    Geneva: {
      country: "Switzerland",
      lat: -1.952099,
      lng: 30.059570,
      label: '<strong>Geneva</strong> 09/10 - 15/10'
    },
    Amsterdam: {
      country: "Netherlands",
      lat: -6.826216,
      lng: 39.269149,
      label: '<strong>Amsterdam</strong> 09/10 - 15/10'
    }
  },

  initializeMap: function() {
    this.options.mobile = window.IS_VERY_SMALL_SCREEN;
    if(this.options.mobile) { return; }

    var self = this;
    L.Icon.Default.imagePath = "/assets/images/leaflet";

    self.m = L.map('bigfatmap', {
      center: [-2.350415, 35.679931],
      zoom: 5,
      scrollWheelZoom: false,
      zoomControl: false,
      tap: true
    });
    self.m.addControl( L.control.zoom({position: 'bottomright'}) );
    self.m.attributionControl.setPrefix('');
    self.m.on("click", function(e) { if(window.console && window.console.log) { console.log(e.latlng); } });
    L.tileLayer('https://{s}.tiles.mapbox.com/v3/aht.map-bo38swvz/{z}/{x}/{y}.png', {
      attribution: '',
      maxZoom: 17
    }).addTo(self.m);

    $.each(this.cities, function(cityName, city) {
      self.addCountryLabel(cityName, city);
    });
  },

  moveToCity: function(cityName) {
    if(this.options.mobile) { return; }

    var city = this.cities[cityName];
    this.m.setView([city.lat, city.lng], 12, {animate: true});
  },

  moveToOverview: function() {
    if(this.options.mobile) { return; }

    this.m.setView([-3.50415, 20.679931], 5, {animate: true});
  },

  addCountryLabel: function(cityName) {
    var city = this.cities[cityName];
    L.marker([city.lat, city.lng])
      .bindLabel(city.label, { noHide: true, className: city.country })
      .addTo(this.m)
      .showLabel();
  },

  addMarkers: function(markers) {
    $.each(markers, function(i, marker) {
      var className = marker.className || marker.country;
      L.marker([marker.lat, marker.lng])
        .bindLabel(marker.label, { noHide: true, className: className})
        .addTo(Hackmap.m)
        .showLabel();
    });
  },

  setHeight: function(value) {
    if(this.options.mobile) { return; }

    $('#bigfatmap').animate({height: value});
    $('.leaflet-container').animate({height: value});
  },
};
