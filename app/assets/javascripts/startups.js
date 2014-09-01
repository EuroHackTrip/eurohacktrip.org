
$(document).ready(function() {

	if(window.location.pathname.indexOf('/startups/new') > -1 
		|| (window.location.pathname.indexOf('/startups/') > -1 && window.location.pathname.indexOf('/edit') > -1)){ 


		$('#new_startup, #edit_startup').validate({
		    rules: {
				'startup[name]': {
				   required: true
				},
				'startup[logo]': {
					required: true,
					width250: true,
					squareish: true
				},
				'startup[city]': {
					required: true,
					minlength: 2
				},
				'startup[tagline]': {
					required: true
				},
	        },
		    messages: {
		       	'startup[name]': {
				    required: 'You must specify your Startup',
				},
				'startup[logo]': {
					required: '<Kindly></Kindly> upload a logo.',
					width250: 'Image width must be at least 250px',
					squareish: 'Your image should be squared'
				},
				'startup[city]': {
				    required: 'You must specify your City/Town',
				    minlength : "City/Town must be atleast 2 characters long"
				},
				'startup[tagline]': {
				    required: 'You must specify your City/Town'
				},
		    },
		    highlight: function (element) {
		        $(element).closest('.field').removeClass('has-success').addClass('has-error');
		    },
		    success: function (element) {
		        element.text('OK!').addClass('valid')
		            .closest('.field').removeClass('has-error').addClass('has-success');
		    }
		});

		// validateImg($('#startup_logo'));
		
		$.validator.addMethod("width250", function(value, element, param) {
			vall = value
			ell = element
	     	return img.width == 0 ? true : (img.width >=250)
		});

		$.validator.addMethod("squareish", function(value, element) {
		    return img.width == 0 ? true : (img_ratio  >= 0.95) && (img_ratio <= 1.05)
		});

		$('#new_startup, #edit_startup').submit(function (e) { 
			// checkLength(CKEDITOR.instances['startup_description'], 20)
			if($('.has-error')[0]){
				e.preventDefault()
				// window.location.hash = $("#"+erroneous).parent().attr('id')
				$('html,body').animate({
				   scrollTop: $("#"+erroneous).parent().position().top + 10
				}, 1000);
			}
			else{
				this.submit()
			}
		})

		// CKEDITOR.instances['startup_description'].on('change', function(){ checkLength(this, 20)})


	lisst = undefined != typeof $('.involvement-list input') ? $.parseJSON($('.involvement-list input').val()) : [];
	deleteEm = function(){
		// console.log(lisst);
		p = $(this).parent('small')
		// console.log(p);
		id = parseInt(p.attr('id').substr(1))
		// console.log(id);
		for(i=0; i< lisst.length; ++i){
			if(lisst[i] === id){
				// console.log(id);
				// console.log(lisst);
				lisst.splice(i,1)
			}
		}
		$('.involvement-list input').val(JSON.stringify(lisst));
		console.log(lisst);
		$('small#_'+id).remove()
	}

	$(".involvement-adder").autocomplete({
	source: function (request, response) {
	    $.ajax({
	        url: "/users/api",
	        type: "GET",
	        cache: false,
	        dataType: "json",
	        success: function (data) {
	            var arr = [];
	            $(data).each(function( index ) {
	                arr.push({label:this.name, value:this.name, id:this.id});
	            });
	            response(arr);
	        },
	        data: {
	            name: request.term
	        }
	    });
	},
	select: function( event, ui ) {
	    // console.log(ui.item);
	    if(lisst.indexOf(ui.item.id) < 0){
		    lisst.push(ui.item.id)
		    $('.involvement-list').append(
		    	'<small class="badge" id="_'+ui.item.id+'"><a href="/users/'+ui.item.id+'">'+
		    	ui.item.value +
				'</a>&nbsp;<i class="fa fa-times-circle"></i>\
				</small>');
		    $('.involvement-list input').val(JSON.stringify(lisst));
	    }
	    setTimeout(function(){
	        $(".involvement-adder").val('');
	    }, 200);
	    console.log(lisst);	
	}
	});	

	$(".involvement-list").on('click', '.badge i', deleteEm)

	}

})