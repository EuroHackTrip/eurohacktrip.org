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

var myIcon = L.icon({
	iconUrl: window.location.origin + '/assets/bubble-pink.png',
	iconSize: [20, 20],
	iconAnchor: [10, 10],
	labelAnchor: [6, 0] // as I want the label to appear 2px past the icon (10 + 2 - 6)
});

//mapping for home, /posts[blog] and /countries pages
if(window.location.pathname == '/' 
	|| window.location.pathname ==  '/posts'
	|| window.location.pathname ==  '/countries'){ 

	// foreach city in the whole fucking hacktrip
	var mapmaker = L.map('allmap', {
		scrollWheelZoom: true,
		zoomControl: false,
		doubleClickZoom: true,
		attributionControl: false,
		}).setView([51.505, -0.09], 5); 
	var markersgroup = []
		   
	L.tileLayer('http://{s}.tile.cloudmade.com/5e9427487a6142f7934b07d07a967ba3/997/256/{z}/{x}/{y}.png', {
	  attribution: 'EuroHackTrip',
	  maxZoom: 18,
	  opacity: 0.5
	}).addTo(mapmaker);

	$.get('/citiez', function(data){ //create markers for all cities in country

		$.each(data, function(key, city){
			console.log(city.name);
			coords = city.map;
			lat = parseFloat(coords.substr(0, coords.indexOf(', ')))
			lng = parseFloat(coords.substr(coords.indexOf(', ')+2, coords.length))
			console.log(lat);
			console.log(lng);
			var marker = L.marker([lat, lng], {
						icon: myIcon
						})
						.bindLabel('<a href="'+window.location.origin+'/countries/'+city.country_id+'">'
									+city.name+'</a>', { 
						//label markers
						noHide: true,
						direction: 'auto'
						}).addTo(mapmaker);
			var popup = L.popup()
			    // .setLatLng(latlng)
			    .setContent('<a href="'+window.location.origin+'/countries/'+city.country_id+'">'
			    			+city.name+'</a><br />'+city.description+'</p>')
			    .openOn(marker);
			marker.bindPopup(popup)

			markersgroup.push([lat, lng])
			// markersgroup.push(marker.getLatLng())
			// console.log(marker.getLatLng());
		})
		mapmaker.fitBounds(markersgroup);

	})
	.fail(function() {
		console.log('check your db bro...');
	})

}

//mapping for single country and single post page
if(window.location.pathname.indexOf('/countries/') > -1){ 

	var map = L.map('map', {
		scrollWheelZoom: true,
		zoomControl: false,
		attributionControl: false,
		}).setView([51.505, -0.09], 5); 
	var markersgroup = []
		   
	L.tileLayer('http://{s}.tile.cloudmade.com/5e9427487a6142f7934b07d07a967ba3/997/256/{z}/{x}/{y}.png', {
	  attribution: 'EuroHackTrip',
	  maxZoom: 18
	}).addTo(map);

	var path = window.location.pathname
	var country_id = path.substr(path.length-1, path.length)

	$.get('/citiez/country/' + country_id, function(data){ //create markers for all cities in country

		$.each(data, function(key, city){
			console.log(city.name);
			coords = city.map;
			lat = parseFloat(coords.substr(0, coords.indexOf(', ')))
			lng = parseFloat(coords.substr(coords.indexOf(', ')+2, coords.length))
			console.log(lat);
			console.log(lng);
			var marker = L.marker([lat, lng], {
						icon: myIcon
						})
						.bindLabel('<a href="'+window.location.origin+'/countries/'+city.country_id+'">'
									+city.name+'</a>', { 
						//label markers
						noHide: true,
						direction: 'auto'
						}).addTo(map);
			var popup = L.popup()
			    // .setLatLng(latlng)
			    .setContent('<a href="'+window.location.origin+'/countries/'+city.country_id+'">'
			    			+city.name+'</a><br />'+city.description+'</p>')
			    .openOn(marker);
			marker.bindPopup(popup)

			markersgroup.push([lat, lng])
			// markersgroup.push(marker.getLatLng())
			// console.log(marker.getLatLng());
		})
		map.fitBounds(markersgroup);
		
	})
	.fail(function() {
		console.log('check your db bro...');
	})

}


if($('form #event_event_link')[0] != undefined && $('form #event_event_link')[0] != null){ 
	//creating or editing an event:

	//eventbrite url into event id
	//http://www.eventbrite.com/e/tedxstrathmoreuniversity-tickets-9346225813?ref=ecount
	//https://www.eventbrite.com/e/euro-hack-trip-first-meetup-tickets-9139643921
	//http://www.eventbrite.com/e/spoken-word-event-tickets-9311395635
	//http://www.eventbritickets-9311395634vfsv
	//remove events easy

	function ValidUrl(str) { //check if string is a valid url
	  var pattern = new RegExp('^(https?:\\/\\/)?'+ // protocol
	  '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+ // domain name
	  '((\\d{1,3}\\.){3}\\d{1,3}))'+ // OR ip (v4) address
	  '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*'+ // port and path
	  '(\\?[;&a-z\\d%_.~+=-]*)?'+ // query string
	  '(\\#[-a-z\\d_]*)?$','i'); // fragment locator
	  if(!pattern.test(str)) {
	    return false;
	  } else {
	    return true;
	  }
	}
	n = $("form#new_event input#event_event_link");
	var event_id = '' 
	// n.on('click', function(){console.log('enter event url');});
	n.on('paste', function(){
	setTimeout(function(){
	  if (ValidUrl(n[0].value)){
	    console.log(n[0].value);
	    event_id = parseInt(n.val().substr(n.val().search("tickets-")+8, n.val().length));
	    console.log(event_id);
	    $('label.fetched').attr('class', 'fetched alert alert-info');
	    $('label.fetched')[0].innerText = "Fetching Event Data..."; 
	    $("form#new_event #eventidlabel").slideToggle(500)
	    var e = {}
	    $.get('/eventbrite/' + event_id, function(e){
	      console.log(e);
	      $("form#new_event input#event_event_id")[0].value = event_id;
	      $("form#new_event input#event_event_name")[0].value = e['title'];
	      $("form#new_event input#event_event_venue")[0].value = e['venue'];
	      $('label.fetched').attr('class', 'fetched alert alert-success');
	      $('label.fetched')[0].innerText = "Successful! " + 0+e['tickets'] + " Tickets Remaining"; 
	      $("form#new_event .eventid").slideToggle(500)
	      setTimeout(function(){
	        $("form#new_event .eventid").slideToggle(500)
	      }, 1000)

	    })
	    .fail(function() {
	      $('label.fetched').attr('class', 'fetched alert alert-warning');
	      $('label.fetched')[0].innerText = "Provide more information...";
	    })
	  }else{
	    $('label.fetched').attr('class', 'fetched alert alert-danger');
	    $('label.fetched')[0].innerText = "Please provide a valid link:"; 
	  }
	}, 200)
	})

}//end creating and editing events


// if(window.location.pathname.indexOf('/posts/') > -1){ 
// }

});  
