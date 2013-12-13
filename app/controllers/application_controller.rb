require 'date'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :posts_count, :comments_count, :all_posts, :all_comments, 
                :all_countries, :all_cities, :all_people, :all_events, 
                :approved_comments_count, :homepage_content, :total_unique, 
                :total_returning, :total_unique_post_views, :page_views, 
                :all_country_posts, :init_date, :total_views, :views_hash, :call_commands
  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, :alert => exception.message
  # end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :activity
    devise_parameter_sanitizer.for(:sign_up) << :is_admin
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

def call_commands
  `mkdir ~/ran_from_within_ruby`
end
  def after_sign_in_path_for(res)
  	dashboard_index_path
  end

  def after_sign_out_path_for(arg)
  	new_admin_session_path
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
end
