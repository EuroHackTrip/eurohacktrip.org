require 'rubygems'
require 'eventbrite-client'

class CountryEvent
	# attr_accessor :id
	def initialize(id)
		@id = id
		response
	end
	def response

		eb_auth_tokens = { app_key: 'POR5GB24DLDRC7HF5T', user_key: '134744050840598882350'}
		eb_client = EventbriteClient.new(eb_auth_tokens)

		response = eb_client.event_get({ id: @id})
		
	    #for testing offline:

	    # response = {'event'=>{'box_header_text_color'=>'404040', 'locale'=>'en_US', 'link_color'=>'0f90ba', 'box_background_color'=>'ffffff', 'box_border_color'=>'dedede', 'timezone'=>'Africa/Nairobi', 'organizer'=>{'url'=>'http://www.eventbrite.com/org/4216382511', 'description'=>'', 'long_description'=>'', 'id'=>4216382511, 'name'=>'NDS'}, 'background_color'=>'f7f7f7', 'id'=>9311395635, 'category'=>'', 'box_header_background_color'=>'fafafa', 'capacity'=>0, 'num_attendee_rows'=>5.0, 'title'=>'Spoken Words', 'start_date'=>'2013-12-01 13:00:00', 'status'=>'Live', 'description'=>'<P>Nairobi Dev School Students will be reading out their work from the creative writing class.</P>\r\n<P>Anyone is welcome to get on stage and share their words! So p<SPAN STYLE=\'font-family: \"Helvetica Neue\", Helvetica, Arial, sans-serif; font-size: 13px; line-height: 20.796875px;\'>Please join  us for this creative and fun afternoon of spoken word!</SPAN></P>', 'end_date'=>'2013-12-01 16:00:00', 'tags'=>'', 'timezone_offset'=>'GMT+0300', 'text_color'=>'404040', 'title_text_color'=>'', 'tickets'=>[{'ticket'=>{'description'=>'', 'end_date'=>'2013-12-01 12:00:00', 'min'=>1, 'max'=>nil, 'price'=>'0.00', 'visible'=>'true', 'currency'=>'USD', 'display_price'=>'0.00', 'type'=>0, 'id'=>21940057, 'name'=>'RSVP'}}], 'created'=>'2013-11-18 02:07:40', 'url'=>'https://nds-spokenword.eventbrite.com/?ref=ebapi', 'box_text_color'=>'666666', 'privacy'=>'Public', 'venue'=>{'city'=>'Nairobi', 'name'=>'iHub', 'country'=>'Kenya', 'region'=>'Nairobi', 'longitude'=>36.790765, 'postal_code'=>'', 'address_2'=>'', 'address'=>'4th Floor, Bishop Magua Centre George Padmore Lane', 'latitude'=>-1.298724, 'country_code'=>'KE', 'id'=>4745601, 'Lat-Long'=>'-1.298724 / 36.790765'}, 'modified'=>'2013-11-18 02:25:16', 'repeats'=>'no'}}

	end


	def widget(response)
		EventbriteWidgets::ticketWidget(response['event'])
	end

end
