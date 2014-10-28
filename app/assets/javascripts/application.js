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
//= require modernizr
//= require jquery-ui
// require jquery.dropotron
// require jquery.popover_menu
//= require bootstrap.min
//= require config
//= require skel.min
//= require skel-panels.min
//= require init
//= require jquery_ujs
//= require posts
//= require dashboard
//= require ckeditor-jquery
//= require social-share-button
//= require jquery.unveilEffects
//= require jquery.pulsate
//= require libs/jquery.hoverdir.js
//= require libs/owl.carousel.js
//= require jquery.nicescroll
//= require jquery.validate
// require additional-methods
// require jqBootstrapValidation
//= require formworks
//= require startups
//= require ekko-lightbox.min



map = {};
$(document).ready(function(){ 

	$('.ckeditor').ckeditor();
	$('#trailer').click(function(){
		$(this).ekkoLightbox();
	})

	var myIcon = L.icon({
		iconUrl: window.location.origin + '/assets/bubble-pink.png',
		iconSize: [20, 20],
		iconAnchor: [10, 10],
		labelAnchor: [6, 0] // as I want the label to appear 2px past the icon (10 + 2 - 6)
	});

	//mapping for home, /posts[blog] and /countries pages
	if($.inArray(window.location.pathname, ['/user', '/users/', '/dashboard', '/posts', '/countries'] > -1)){ 

		// foreach city in the whole hacktrip
		map = L.map('allmap', {
			scrollWheelZoom: false,
			zoomControl: true,
			doubleClickZoom: true,
			// attributionControl: false,
			// }).setView([53, 8], 5); 
			}).setView([50, -10], 5); 
		var markersgroup = []
			   
		// L.tileLayer('http://{s}.tile.cloudmade.com/5e9427487a6142f7934b07d07a967ba3/997/256/{z}/{x}/{y}.png', {
		// L.tileLayer('http://a.tiles.mapbox.com/v3/techytimo.ic2cif8j/{z}/{x}/{y}.png', {
		L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		  attribution: '© <a href="http://openstreetmap.org/copyright">OpenStreetMap</a> contributors',
		  maxZoom: 18,
		  opacity: 0.5
		}).addTo(map);
		$.get('/citiez', function(data){ //create markers for all cities in country

			$.each(data, function(key, city){
				// console.log(city.name);
				coords = city.map;
				lat = parseFloat(coords.substr(0, coords.indexOf(', ')))
				lng = parseFloat(coords.substr(coords.indexOf(', ')+2, coords.length))
				// console.log(lat);
				// console.log(lng);
				var marker = L.marker([lat, lng], {
							icon: myIcon
							})
							.bindLabel('<a href="/cities/'+city.slug+'">'
										+city.name+'</a>', { 
							noHide: true,
							direction: 'auto'
							})
							.addTo(map);
				var popup = L.popup()
				    // .setLatLng(latlng)
				    .setContent('<a href="/cities/'+city.slug+'">'
				    			+city.name+'</a><br />'
				    			+'<a href="/events/'+city.event_id+'">'+city.theme+'</a><br />'
				    			+city.dates+'</p>')
				    .openOn(marker);
				marker.bindPopup(popup)

				marker._icon.onmouseover = function(){
					marker.openPopup()
				}

				markersgroup.push([lat, lng])
				// markersgroup.push(marker.getLatLng())
				// console.log(marker.getLatLng());
			})
			
			// map.fitBounds(markersgroup);
			// setTimeout(function(){ map.panBy([0, -20]); }, 1000)

			// custom parallax effect... 
			pos = 0
			$(window).scroll(function(){ 
				// console.log(pos);
				// console.log($(window).scrollTop());
				// map.panBy([0, -($(window).scrollTop()/10-pos)]);
				// pos = $(window).scrollTop()/10
				map.panBy([0, -($(window).scrollTop()-pos)]);
				pos = $(window).scrollTop()
				// scroll = $(window).scrollTop() > pos ? $(window).scrollTop()-pos : pos - $(window).scrollTop())
				// pos = $(window).scrollTop() > pos ? $(window).scrollTop()-pos : pos - $(window).scrollTop())
			})

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
		    // console.log(n[0].value);
		    event_id = parseInt(n.val().substr(n.val().search("tickets-")+8, n.val().length));
		    // console.log(event_id);
		    $('label.fetched').attr('class', 'fetched alert alert-info');
		    $('label.fetched')[0].innerText = "Fetching Event Data..."; 
		    $("form#new_event #eventidlabel").slideToggle(500)
		    var e = {}
		    $.get('/eventbrite/' + event_id, function(e){
		      // console.log(e);
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

	//mapping for cities
	if($('select#city_country_id')){ 
		$('select#city_country_id').click(function(){
			// console.log('clicked a#to-cities')
			map1 = L.map('mapmaker').setView([51.505, -0.09], 6); 
			L.tileLayer('http://a.tiles.mapbox.com/v3/techytimo.ic2cif8j/{z}/{x}/{y}.png', {
				attribution: 'EuroHackTrip',
				maxZoom: 18
			}).addTo(map1);


			var myIcon = L.icon({
				iconUrl: '/assets/bubble-pink.png',
				iconSize: [20, 20],
				iconAnchor: [10, 10],
				labelAnchor: [6, 0] // as I want the label to appear 2px past the icon (10 + 2 - 6)
			});

			var marker = L.marker()

			function onMapClick(e) {
			console.log(e)

			marker
			  .setLatLng(e.latlng)
			  .setIcon(myIcon)
			  .addTo(map1);

			$('#city_map')[0].value = e.latlng.lat + ', ' + e.latlng.lng 
			}

		map1.on('click', onMapClick)

		})
	}
	
	styleThumbs = function(){
		w = parseInt($('.pennant').css('width'))
		$('.pennant .after').css('border-left', 'solid '+ w/2 +'px transparent' )
		$('.pennant .after').css('border-right', 'solid '+ w/2 +'px transparent' )
	}
	styleThumbs()
	// newFontSize = Math.floor(14 * percentage);
	$( window ).resize(function() {
		if($(window).width() < 650){
			$('h1#logo a').css("font-size", ($(window).width()*0.075)+"px");
			$('h1#logo a').css("letter-spacing", ($(window).width()*0.013)+"px");
		}
		else{
			$('h1#logo a').css("font-size", "50px");
			$('h1#logo a').css("letter-spacing", "13px");
		}
		
		styleThumbs()
	});

	//smoothscroll
	$('a[href*=#]:not([href=#]):not([data-toggle=tab])').click(function() {
		if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
		  var target = $(this.hash);
		  target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
		  if (target.length) {
		    $('html,body').animate({
		      scrollTop: target.offset().top
		    }, 1000);
		    return false;
		  }
		}
	});

    $('.add-startup, .donate').pulsate({
		// color: $(this).css("background-color"), // set the color of the pulse
	    color: "#EF8376",
		reach: 10,                              // how far the pulse goes in px
		speed: 1000,                            // how long one pulse takes in ms
		pause: 0,                               // how long the pause between pulses is in ms
		glow: true,                             // if the glow should be shown too
		repeat: true,                           // will repeat forever if true, if given a number will repeat for that many times
		// onHover: true                          // if true only pulsate if user hovers over the element
	});

	// Hover and Carousel
	$('.owl-carousel > .item ').each( function() { $(this).hoverdir(); } );
		$("#owl-demo").owlCarousel({
		items : 5,
		autoPlay: 3000, //Set AutoPlay to 3 seconds
		stopOnHover : true,
		lazyLoad : true,
		transitionStyle:"fade",
		navigation : true,
		pagination : false,
	});

	// nice scroll
	if(window.location.pathname != "/dashboard/index"){
  		$("html").niceScroll({styler:"fb",cursorcolor:"#ed786a", cursorwidth: '6', cursorborderradius: '10px', background: 'transparent', spacebarenabled:false,  cursorborder: '', zindex: '1000', autohidemode: false});
	}		


  	niceScrollTw = function(){ 
	  		console.log('twitter iframe loaded');
  		// d = $('iframe#twitter-widget-0').contents().find(".timeline .stream")
  		// d.niceScroll({styler:"fb",cursorcolor:"#ed786a", cursorwidth: '6', cursorborderradius: '10px', background: 'transparent', spacebarenabled:false,  cursorborder: '', zindex: '1000', autohidemode: false});
  	};  

	// $("#user-menu").optionsPopover({
 //        id: "user-menu",
 //        title: "Hello World!",
 //        contents: [
 //            {"name": "Menu Item 1", url: "m1"},
 //            {"name": "Menu Item 2", id: "m2"},
 //            {"name": "Link to second button's menu...", id: "menu2"}
 //        ]
 //    });
	// $('.menu1').popover_menu({
	//   anchorTo : '#user-menu', // Positions the menu near this element. See ExtJs's alignTo for more details
	//   pointer : 'north',  // Adds an upward pointing arrow. Use 'south' for a downward facing arrow.
	//   show : false,       // FALSE to not display the menu upon creation
	//   width : 250,        // A specific width for the menu. Leave NULL to use the width of the content element (#foo in this case)
	//   height : 400,       // A specific height for the menu. Leave NULL to use the height of the content element (#foo in this case)
	//   'z-index' : 10000,
	//   // init : function() { // A callback method to run after the menu has been initialized
	//   //   this.find('li:first-child a').addClass('selected');
	//   // }
	// });

	// image hover overlay effect
    if (Modernizr.touch) {
        // show the close overlay button
        $(".close-overlay").removeClass("hidden");
        // handle the adding of hover class when clicked
        $(".partners li").click(function(e){
            if (!$(this).hasClass("hover")) {
                $(this).addClass("hover");
            }
        });
        // handle the closing of the overlay
        $(".close-overlay").click(function(e){
            e.preventDefault();
            e.stopPropagation();
            if ($(this).closest(".partners li").hasClass("hover")) {
                $(this).closest(".partners li").removeClass("hover");
            }
        });
    } else {
        // handle the mouseenter functionality
        $(".partners li").mouseenter(function(){
            $(this).addClass("hover");
        })
        // handle the mouseleave functionality
        .mouseleave(function(){
            $(this).removeClass("hover");
        });
    }

});  
