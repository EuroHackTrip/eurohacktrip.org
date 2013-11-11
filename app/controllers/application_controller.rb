class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :posts_count, :comments_count, :all_posts, :all_comments

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
  	posts_path
  end

  def after_sign_out_path_for(arg)
  	new_admin_session_path
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

  def all_comments
  	Comment.all.order("approved")
  end
end
