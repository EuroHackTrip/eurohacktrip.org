// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootsy
//= require bootstrap
//= require posts
//= require dashboard
//= require ckeditor-jquery


$(document).ready(function(){ 

$('.ckeditor').ckeditor({
  // optional config
});

// if(window.location.pathname == '/' || window.location.pathname ==  '/posts'){ 
// //mapping for home and /posts page

// 	var mapmaker = L.map('map', {
// 	  scrollWheelZoom: false,
// 	  zoomControl: false,
// 	  attributionControl: false,
// 	}).setView([50.005, -7], 5); 

// 	L.tileLayer('http://{s}.tile.cloudmade.com/5e9427487a6142f7934b07d07a967ba3/114841/256/{z}/{x}/{y}.png', {
// 	  attribution: 'EuroHackTrip',
// 	  maxZoom: 18,
// 	  opacity: 0.5
// 	}).addTo(mapmaker);

// 	var myIcon = L.icon({
// 	iconUrl: 'assets/bubble-pink.png',
// 	iconSize: [20, 20],
// 	iconAnchor: [10, 10],
// 	labelAnchor: [6, 0] // as I want the label to appear 2px past the icon (10 + 2 - 6)
// 	});

// 	L.marker([51.72703, -0.04395], {
// 	icon: myIcon
// 	})
// 	.bindLabel("London", {
// 	noHide: true,
// 	direction: 'auto'
// 	}).addTo(mapmaker); 

// 	L.marker([48.89362, 2.37305], {
// 	icon: myIcon
// 	})
// 	.bindLabel("Paris", {
// 	noHide: true,
// 	direction: 'auto'
// 	}).addTo(mapmaker); 

// 	L.marker([50.76426, 4.79004], {
// 	icon: myIcon
// 	})
// 	.bindLabel("Brussels", {
// 	noHide: true,
// 	direction: 'auto'
// 	}).addTo(mapmaker);

// 	L.marker([52.32191, 5.18555], {
// 	icon: myIcon
// 	})
// 	.bindLabel("Amsterdam", {
// 	noHide: true,
// 	direction: 'auto'
// 	}).addTo(mapmaker); 

// 	L.marker([52.45601, 13.27148], {
// 	icon: myIcon
// 	})
// 	.bindLabel("Berlin", {
// 	noHide: true,
// 	direction: 'auto'
// 	}).addTo(mapmaker); 

// 	L.marker([46.98025, 7.60254], {
// 	icon: myIcon
// 	})
// 	.bindLabel("Zurich", {
// 	noHide: true,
// 	  direction: 'auto'
// 	}).addTo(mapmaker); 


// 	// var popup = L.popup();//initialize a leaflet popup and assign it to a variable
// 	// function onMapClick(e) {
// 	//     popup
// 	//         .setLatLng(e.latlng)
// 	//         .setContent("You clicked the mapmaker at " + e.latlng.toString())
// 	//         .openOn(mapmaker);//activate the 'popup'
// 	// };
// 	// mapmaker.on('click', onMapClick);
// }

});  
