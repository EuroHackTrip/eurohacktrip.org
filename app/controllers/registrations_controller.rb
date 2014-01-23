class RegistrationsController < Devise::RegistrationsController
    def create
      if verify_recaptcha
        # @admin = Admin.find_for_facebook_oauth(request.env["omniauth.auth"], current_admin)
        super
      else
        build_resource
        clean_up_passwords(resource)
        flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
        flash.delete :recaptcha_error
        render :new
      end
    end

    protected

    # def after_sign_up_path_for(resource)
    #   'home_index_path'
    # end
  end