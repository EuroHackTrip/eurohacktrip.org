require 'date'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :posts_count, :comments_count, :all_posts, :all_comments, 
                :all_countries, :all_cities, :all_people, :all_events, 
                :approved_comments_count, :homepage_content, :total_unique, 
                :total_returning, :total_unique_post_views, :page_views, 
                :all_country_posts, :init_date, :total_views, :views_hash, 
                :alerts_hash, :posts_by_author, :nick_names, :author, :author_path,
                :file_dimensions
  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, :alert => exception.message
  # end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # for sign up
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :tag_line
    devise_parameter_sanitizer.for(:sign_up) << :interest
    devise_parameter_sanitizer.for(:sign_up) << :funding_profile
    devise_parameter_sanitizer.for(:sign_up) << :video_link
    devise_parameter_sanitizer.for(:sign_up) << :country
    devise_parameter_sanitizer.for(:sign_up) << :photo
    devise_parameter_sanitizer.for(:sign_up) << :activity
    devise_parameter_sanitizer.for(:sign_up) << :is_admin
    devise_parameter_sanitizer.for(:sign_up) << :provider
    devise_parameter_sanitizer.for(:sign_up) << :uid
    devise_parameter_sanitizer.for(:sign_up) << :name

    # for account update
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :tag_line
    devise_parameter_sanitizer.for(:account_update) << :interest
    devise_parameter_sanitizer.for(:account_update) << :funding_profile
    devise_parameter_sanitizer.for(:account_update) << :video_link
    devise_parameter_sanitizer.for(:account_update) << :country
    devise_parameter_sanitizer.for(:account_update) << :photo
    devise_parameter_sanitizer.for(:account_update) << :activity
    devise_parameter_sanitizer.for(:account_update) << :is_admin
    devise_parameter_sanitizer.for(:account_update) << :provider
    devise_parameter_sanitizer.for(:account_update) << :uid
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :approved
  end

  def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  if (request.fullpath != "/users/sign_in" &&
      request.fullpath != "/users/sign_up" &&
      request.fullpath != "/users/password" &&
      !request.xhr?) # don't store ajax calls
    session[:previous_url] = request.fullpath 
  end
end

def after_sign_in_path_for(res)
  	dashboard_index_path
  end

  def after_sign_out_path_for(arg)
  	new_admin_session_path
  end

  def after_sign_up_path_for(resource)
      'home_index_path'
  end

  def current_user
   @current_admin
  end

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

  def all_people
  	Person.all
  end

  def all_events
    Event.all
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

  def homepage_content
    HomepageContent.all
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
    Page.all.each do |page|
      count = count + page.impressionist_count(:filter=>:ip_address)
    end
    Country.all.each do |country|
      count = count + country.impressionist_count(:filter=>:ip_address)
    end
    count
  end

  def alerts_hash
    alerts = {
      'notice' => 'alert alert-success',
      'alert' => 'alert alert-danger'
    }
  end

  def posts_by_author(user)
    posts_by_author = []
    all_posts.each do |post|
      if post.admin_id && post.admin_id == user.id
        if admin_signed_in? || post.published
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
    #   Admin.all.each do |user|
    #     user.first_name + "-" + user.last_name => user.id
    #   end
    # }
    # nick_names
    @arr = []
    Admin.all.each do |user|
      if user.first_name && user.last_name
        @arr << user.first_name + "-" + user.last_name + "=>" + user.id.to_s
      end
    end
    @arr
  end

  def author(post)
    if Admin.find(post.admin_id).first_name && Admin.find(post.admin_id).first_name
      author = Admin.find(post.admin_id).first_name + " " + Admin.find(post.admin_id).last_name
    end
    author
  end

  def author_path(user)
    if user.first_name && user.last_name
      "/#{user.first_name}-#{user.last_name}"
    end
  end

  def file_dimensions
    dimensions = Paperclip::Geometry.from_file(photo.queued_for_write[:original].path)
    if ((dimensions.width < 250 && dimensions.height < 250 ) && (0.8 <= dimensions.width / dimensions || dimensions.width / dimensions <= 1.2))
        errors.add(:photo,'Image must be a square of at least 250px')
    end
  end
end