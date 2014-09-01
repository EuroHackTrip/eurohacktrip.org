$(document).ready(function() {

	// //mapping for single country and single post page
	// if(window.location.pathname.indexOf('/countries/') > -1){ 

	// 	map = L.map('map', {
	// 		scrollWheelZoom: false,
	// 		zoomControl: true,
	// 		attributionControl: false,
	// 		}).setView([51.505, -0.09], 5); 
	// 	var markersgroup = []
			   
	// 	L.tileLayer('http://{s}.tile.cloudmade.com/5e9427487a6142f7934b07d07a967ba3/997/256/{z}/{x}/{y}.png', {
	// 		attribution: 'EuroHackTrip',
	// 		maxZoom: 18
	// 	}).addTo(map);

	// 	var myIcon = L.icon({
	// 		iconUrl: window.location.origin + '/assets/bubble-pink.png',
	// 		iconSize: [20, 20],
	// 		iconAnchor: [10, 10],
	// 		labelAnchor: [6, 0] // as I want the label to appear 2px past the icon (10 + 2 - 6)
	// 	});

	// 	var path = window.location.pathname
	// 	// var country_id = path.substr(path.length-1, path.length)
	// 	// var country_name = country_name = path.substr(11, path.length)
	// 	var country_id = $('#map').data('country-id')

	// 	apiFetch = function(){
	// 		$.get('/citiez/country/' + country_id, function(data){ //create markers for all cities in country
	// 			$.each(data, function(key, city){
	// 				// console.log(city.name);
	// 				coords = city.map;
	// 				lat = parseFloat(coords.substr(0, coords.indexOf(', ')))
	// 				lng = parseFloat(coords.substr(coords.indexOf(', ')+2, coords.length))
	// 				// console.log(lat);
	// 				// console.log(lng);
	// 				var marker = L.marker([lat, lng], {
	// 							icon: myIcon
	// 							})
	// 							.bindLabel('<a href="'+window.location.origin+'/countries/'+city.country_name+'">'
	// 										+city.name+'</a>', { 
	// 							//label markers
	// 							noHide: true,
	// 							direction: 'auto'
	// 							})
	// 							.addTo(map);
	// 				var popup = L.popup()
	// 				    // .setLatLng(latlng)
	// 				    .setContent('<a href="'+window.location.origin+'/countries/'+city.country_name+'">'
	// 				    			+city.name+'</a><br />'+city.description+'</p>')
	// 				    .openOn(marker);
	// 				marker.bindPopup(popup)

	// 				markersgroup.push([lat, lng])
	// 				// markersgroup.push(marker.getLatLng())
	// 				// console.log(marker.getLatLng());
	// 			})			
	// 			map.fitBounds(markersgroup);
	// 			setTimeout(function(){ map.panBy([0, -20]); }, 1000)
	// 		})
	// 		.fail(function() {
	// 			console.log('check your db bro...');
	// 		})
	// 	}

	// 	domFetch = function(){
	// 		_record = $.parseJSON($('.dd').html() || '{}')
	// 		afterFetch(_record)
	// 	}
		  
		
	// 	apiFetch()
	// }

})