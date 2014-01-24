class RegistrationsController < Devise::RegistrationsController

    # def new
    #   @message = Message.new
    # end
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

    def file_dimensions
      dimensions = Paperclip::Geometry.from_file(photo.queued_for_write[:original].path)
      if ((dimensions.width < 250 && dimensions.height < 250 ) && (0.8 <= dimensions.width / dimensions || dimensions.width / dimensions <= 1.2))
          errors.add(:photo,'Image must be a square of at least 250px')
      end
    end

    protected

    # def after_sign_up_path_for(resource)
    #   'home_index_path'
    # end
  end