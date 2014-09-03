require 'date'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :posts_count, :comments_count, :all_posts, :all_comments, 
  :all_countries, :all_cities, :all_people, :all_startups, :all_stops, 
  :all_partners, :partner_tiers, :involved_in,
  :approved_comments_count, :homepage_content, :total_unique, 
  :total_returning, :total_unique_post_views, :page_views, 
  :all_country_posts, :init_date, :total_views, :views_hash, 
  :alerts_hash, :posts_by_author, :nick_names, :author, :author_path,
  :message, :embed_link, :countries, :current_user, :shorten
  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, :alert => exception.message
  # end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # for sign up
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :photo
    devise_parameter_sanitizer.for(:sign_up) << :video
    devise_parameter_sanitizer.for(:sign_up) << :about
    devise_parameter_sanitizer.for(:sign_up) << :interest
    devise_parameter_sanitizer.for(:sign_up) << :country
    devise_parameter_sanitizer.for(:sign_up) << :city
    devise_parameter_sanitizer.for(:sign_up) << :funding_campaign
    devise_parameter_sanitizer.for(:sign_up) << :is_admin
    devise_parameter_sanitizer.for(:sign_up) << :provider
    devise_parameter_sanitizer.for(:sign_up) << :uid
    devise_parameter_sanitizer.for(:sign_up) << :name

    # for account update
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :password
    devise_parameter_sanitizer.for(:account_update) << :photo
    devise_parameter_sanitizer.for(:account_update) << :video
    devise_parameter_sanitizer.for(:account_update) << :about
    devise_parameter_sanitizer.for(:account_update) << :interest
    devise_parameter_sanitizer.for(:account_update) << :country
    devise_parameter_sanitizer.for(:account_update) << :city
    devise_parameter_sanitizer.for(:account_update) << :funding_campaign
    devise_parameter_sanitizer.for(:account_update) << :is_admin
    devise_parameter_sanitizer.for(:account_update) << :provider
    devise_parameter_sanitizer.for(:account_update) << :uid
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :approved
  end

def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  if (request.fullpath != "/login" &&
    request.fullpath != "/register" &&
    request.fullpath != "/users/password" &&
      !request.xhr?) # don't store ajax calls
    session[:previous_url] = request.fullpath 
  end
end

def after_sign_in_path_for(res)
  dashboard_index_path
end

def after_sign_out_path_for(arg)
  new_user_session_path
end

def after_sign_up_path_for(resource)
  'home_index_path'
end

# def current_user
#  @current_user ||=  User.find(session['user_id']) if session['user_id']
# end

def posts_count
  Post.all.count
end

def comments_count
  Comment.all.count
end

def all_posts
  Post.all
end

def all_country_posts(country)
  if PostSetting.all.count > 0
    Post.all.tagged_with(country).paginate(:page => params[:page], :per_page => PostSetting.last.posts_per_page)
  else
    Post.all.tagged_with(country).paginate(:page => params[:page], :per_page => 10)
  end
end

def all_post_settings
  PostSetting.all
end

def all_comments
  Comment.all.order("approved desc")
end

def all_countries
  Country.all
end

def all_cities
  City.all
end

def all_startups
  Startup.all
end

def all_stops
  Stop.all
end

def all_partners
  Partner.all
end

def approved_comments_count(post)
  count = 0
  post.comments.each do |comment|
    if comment.approved
      count = count + 1
    end
  end
  count
end

def init_date
  today_date = Time.now.to_s.split(" ")[0]
  year = today_date.split("-")[0].to_i
  month = today_date.split("-")[1].to_i
  day = today_date.split("-")[2].to_i
  date = Date.new(year, month, day)
end

def views_hash
  views = {
    'Unique Visitors' => total_unique_post_views,
    'Returning Visitors' => total_returning,
    'Pageviews today' => page_views(init_date, init_date),
    'Pageviews Yesterday' => page_views(init_date.yesterday, init_date),
    'Pageviews this week' => page_views(init_date.beginning_of_week, init_date),
    'Pageviews this month' => page_views(init_date.beginning_of_month, init_date),
    'Pageviews all time' => total_views
  }
end

def total_unique_post_views
  count = 0
  all_posts.each do |post|
    count = count + post.impressionist_count(:filter=>:ip_address)
  end
  count
end

def total_returning
  count = 0
  all_posts.each do |post|
    count = count + post.impressionist_count
  end
  count
end

def page_views(from, to)
  #from = eval(from).to_date
  #to = eval(to).to_date
  count = 0
  all_posts.each do |post|
    count = count + post.impressionist_count(:start_date=>from,:end_date=>to)
  end
  count
end

def total_views
  count = total_unique_post_views
  Country.all.each do |country|
    count = count + country.impressionist_count(:filter=>:ip_address)
  end
  count
end

def alerts_hash
  alerts = {
    'notice' => 'alert alert-success mids',
    'alert' => 'alert alert-danger mids'
  }
end

  def posts_by_author(user)
    posts_by_author = []
    all_posts.each do |post|
      if post.user_id && post.user_id == user.id
        if user_signed_in? || post.published
          posts_by_author << post
        end
      end
    end
    posts_by_author
  end

  # def country_id_for_post(post)
  #   all_countries.each do |country|
  #     if post.tag_list[0] == country
  #       country_id = country.id
  #     end
  #   end
  #   country_id
  # end

  def nick_names
    # nick_names = {
    #   User.all.each do |user|
    #     user.first_name + "-" + user.last_name => user.id
    #   end
    # }
    # nick_names
    @arr = []
    User.all.each do |user|
      if user.first_name && user.last_name
        @arr << user.first_name + "-" + user.last_name + "=>" + user.id.to_s
      end
    end
    @arr
  end

  def author(post)
    if User.find(post.user_id).first_name && User.find(post.user_id).first_name
      author = User.find(post.user_id).first_name + " " + User.find(post.user_id).last_name
    end
    author
  end

  def author_path(user)
    if user.first_name && user.last_name
      "/#{user.first_name}-#{user.last_name}"
    end
  end

  def embed_link(yt_link)
    # www.youtube.com/watch?v=3K7tYdUZZ_c
   # //www.youtube.com/embed/3K7tYdUZZ_c
   yt_link.gsub("watch?v=", "embed/")
  end

  def message
    @message = Message.new
  end
  
  def countries
    countries = ["Afghanistan", "Aland Islands", "Albania", "Algeria", "American Samoa", "Andorra", "Angola",
        "Anguilla", "Antarctica", "Antigua And Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria",
        "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin",
        "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil",
        "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia",
        "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China",
        "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo",
        "Congo, the Democratic Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba",
        "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt",
        "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)",
        "Faroe Islands", "Fiji", "Finland", "France", "French Guiana", "French Polynesia",
        "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea",
        "Guinea-Bissau", "Guyana", "Haiti", "Heard and McDonald Islands", "Holy See (Vatican City State)",
        "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran, Islamic Republic of", "Iraq",
        "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya",
        "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan",
        "Lao People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya",
        "Liechtenstein", "Lithuania", "Luxembourg", "Macao", "Macedonia, The Former Yugoslav Republic Of",
        "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique",
        "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of",
        "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru",
        "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger",
        "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau",
        "Palestinian Territory, Occupied", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines",
        "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation",
        "Rwanda", "Saint Barthelemy", "Saint Helena", "Saint Kitts and Nevis", "Saint Lucia",
        "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Samoa", "San Marino",
        "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore",
        "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa",
        "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "Sudan", "Suriname",
        "Svalbard and Jan Mayen", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic",
        "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Timor-Leste",
        "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan",
        "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom",
        "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela",
        "Viet Nam", "Virgin Islands, British", "Virgin Islands, U.S.", "Wallis and Futuna", "Western Sahara",
        "Yemen", "Zambia", "Zimbabwe"]
  end
  
  # def api(@table)
  #   @message = Message.new
  # end
  def shorten (string, count)
    if string.length >= count
      shortened = string[0, count]
      splitted = shortened.split(/\s/)
      words = splitted.length
      splitted[0, words-1].join(" ")
    else
      string
    end
  end

  def partner_tiers
    partner_tiers = [
      ['Gold', '50%+ Funding', 0], # EuroAfrica, GIZ, ukaid, infodev, IST-Africa, africa-eu-partnership.org
      ['Silver', '20%+ Funding', 1], # mozilla, google, git, safaricom
      ['Bronze', '5%+ Funding', 2], # other local orgs
      ['Strategic', 'Travel, Accomodation, Event Curation', 3], # Airlines, Bus/Trains, Hubs, Hotels
      ['Media', 'Broadcast the news, Shoot Film', 4], # mashable, bbc, cnn, ventureburn, humanipo, cio, next billion, 
      ['Outreach', 'Get the word out. Connect us to other partners', 5], # ggg, ihub, mlab, nailab, aspen
      ['Founding', 'Founding Consortium', 6], # thedevs, aht 
    ]
  end

  # module EU
    # def self.involved_in(x)
    #   return involved_in(x)
    # end
    def involved_in(model)
      unless model.users.include?(current_user) || current_user.id == 1
        return false
      end
      return true
    end
  # end

  # def is_admin
  #   if current_user && current_user.is_admin
  #     return true
  #   end
  #   return false
  # end
end