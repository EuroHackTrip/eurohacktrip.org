$(document).ready(function() {

	$('.participation label').click(function() { //startup participations, highlight active
	    // $(this).addClass('active').siblings().removeClass('active');
	    $(this).button('toggle');
	 //    pn = $('.participation label').map(function(){
		// 	return $(this).is('.active') ? parseInt($(this).attr('for')) : null;
		// }).get();
	 //    $('input[name="participation"]').last().val(pn);
	});

	$('input[type="file"]').next().on('click', function(e){
		e.preventDefault()
		// console.log($(this));
		$(this).val('')
			.parent('span.has-error').attr('class', 'has-success')
			.children('label.error').remove(); 
			img_ratio =1
	})


	validateImg = function(ell){
		ell.change(function(){
		    img.src = _URL.createObjectURL(ell[0].files[0])
		    // console.log(img.src);
		    setTimeout(function(){ // take some time before requesting width and height
			    // console.log(img.width);
			    // console.log(img.height);
		    	img_ratio = img.width / img.height
			    // console.log(img_ratio);

			    if($(ell).next().attr('class') == 'error'){
		    		er = $(ell).next();
					if(img.width < 250){
						er.html('The image should be at least 250px wide.').show();
						$(ell.parentNode).removeClass('has-success').addClass('has-error');
					}
					else if((img_ratio  < 0.8) || (img_ratio > 1.2)){
						er.html('Your image should be squared.').show();
						$(ell.parentNode).removeClass('has-success').addClass('has-error');
					}
					else{
						er.html('Good!').show();
						$(ell.parentNode).removeClass('has-error').addClass('has-success').show();
					}

			    }

			}, 1000);
		})
		
	};

	checkLength = function(f, length){
		ckinstance = f
		txtarea = f.element.$
		console.log('checking ' + txtarea.id);
		setTimeout(function(){
			console.log(wCount);
			// l = ckinstance.getData().length
			// console.log(l);
			if(wCount <length){
				erroneous = txtarea.id
				console.log(erroneous);
				console.log($('label.'+erroneous));
				$('label.'+erroneous).html('Type in at least '+length+' words.')
				$(txtarea.parentNode).removeClass('has-success').addClass('has-error');
			}
			else{
				$('label.'+txtarea.id).html('Good!')
				$(txtarea.parentNode).removeClass('has-error').addClass('has-success');
			}
		}, 200)
	}


	ell = {}
	vall = {}
	validation = {}
	img = new Image();
	dd = ''
	erroneous = ''
	wCount = 0
	cCount = 0
	var _URL = window.URL || window.webkitURL;

	// front-end form validation, like a bozz...
	if($.inArray(window.location.pathname,  ['/register', '/account/edit', '/users']) > -1){ 
		
	// jqBootstrapValidation http://reactiveraven.github.io/jqBootstrapValidation/
	// $("input,select,textarea").not("[type=submit]").jqBootstrapValidation();


		sign_up_validation = {
		    rules: {
				'user[video]': {
				   // required: true,
				   // minlength: 30,
				   url: true
				},
				'user[first_name]': {
				   required: true,
				   minlength: 2
				},
				'user[last_name]': {
				   required: true,
				   minlength: 2
				},
				'user[email]': {
				   required: true,
				   email: true
				},
				'user[password]': {
					required: true,
					minlength: 3
				},
				'user[password_confirmation]': {
					equalTo: '#user_password'
				},
				'user[photo]': {
					required: true,
					width250: true,
					squareish: true
				},
				'user[country]': {
				    required: true,
				},
				'user[city]': {
				    required: true,
				    minlength: 2
				}
		    },
	        messages: {
				'user[video]': {
				    // minlength: "Please enter a valid Youtube video link"
				},
				'user[first_name]': {
				    minlength: "First Name should be atleast 2 characters"
				},
				'user[last_name]': {
				    minlength: "Last Name should be atleast 2 characters"
				},
				'user[email]': {
				    email: "You entered and invalid email address",
				},
				'user[password]': {
				    minlength : "Password be atleast 3 characters long",
				},
				'user[password_confirmation]': {
				    equalTo: "Should match with the password above!"
				},
				'user[photo]': {
					required: 'You must upload a photo of yourself!',
					width250: 'Image width must be at least 250px',
					squareish: 'Your image should be squared'
				},
				'user[country]': {
				    required: 'You must specify your country'
				},
				'user[city]': {
				    required: 'You must specify your city',
				    minlength:  "City should be atleast 2 characters long"
				}
	        },
		    highlight: function (element) {
		        $(element).closest('.field').removeClass('has-success').addClass('has-error');
		    },
		    success: function (element) {
	        	element.text('Good!').addClass('valid')
	        	.closest('.field').removeClass('has-error').addClass('has-success');
		    }
		}

		// registration form

		$('#sign_up')[0] ? $('#sign_up').validate(sign_up_validation) : true;

		// edit account form
		edit_validation = sign_up_validation
		edit_validation['rules']['user[password]'].required = undefined
		edit_validation['rules']['user[current_password]'] = undefined
		edit_validation['rules']['user[photo]'].required = undefined

		// $('#edit_user')[0] ? $('#edit_user').validate(edit_validation) : true;
		

		$.validator.addMethod("easy", function(value, element, param) {
			vall = value
			ell = element
			return value == 'easy'
		}, 'just type easy...');

		
		// validateImg($('#user_photo'));

		$.validator.addMethod("width250", function(value, element, param) {
			vall = value
			ell = element
	     	return img.width == 0 ? true : (img.width >=250)
		});

		$.validator.addMethod("squareish", function(value, element) {
		    return img.width == 0 ? true : (img_ratio  >= 0.95) && (img_ratio <= 1.05)
		});

		// $('#sign_up, #edit_user').submit(function (e) { 
		// 	e.preventDefault()
		// 	$.each(CKEDITOR.instances, function(){ //necessary on registration
		// 		checkLength(this, 20)
		// 	})
		// 	if($('.has-error')[0]){
		// 		console.log('has error on '+erroneous);
		// 		e.preventDefault()
		// 		// window.location.hash = $("#"+erroneous).parent().attr('id')
		// 		$('html,body').animate({
		// 		   scrollTop: $("#"+erroneous).parent().position().top + 10
		// 		}, 1000);
		// 	}
		// 	else{
		// 		// this.submit()
		// 	}
		// })

		// $.each(CKEDITOR.instances, function(){
		// 	this.on('change', function(){ checkLength(this, 20)})
		// })

	}	


	if(window.location.pathname.indexOf('/register') > -1){ 

		$('#sign_in').validate({
		    rules: {
				'user[email]': {
				   required: true,
				   email: true
				},
				'user[password]': {
					required: true,
					minlength: 3
				},
	        },
		    messages: {
		       	'user[email]': {
				    email: "You entered and invalid email address",
				},
				'user[password]': {
				    minlength : "Password be atleast 3 characters long",
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
	}

});