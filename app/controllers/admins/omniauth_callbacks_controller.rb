class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
    # You need to implement the method below in your model (e.g. app/models/admin.rb)
    @admin = Admin.find_for_facebook_oauth(request.env["omniauth.auth"], current_admin)

    if @admin.persisted?
      sign_in_and_redirect @admin, :event => :authentication #this will throw if @admin is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_admin_registration_url
    end
  end
end