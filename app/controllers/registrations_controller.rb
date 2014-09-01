class RegistrationsController < Devise::RegistrationsController

  def create
    unless sign_up_params['first_name'] ==  sign_up_params['last_name'] #blocking some spam
      # render json: sign_up_params['first_name']
      build_resource(sign_up_params)

      if resource.save
        yield resource if block_given?
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
            # [video, first_name, last_name, email, photo, country, city, about, interest, funding_campaign]
            # redirect_to thing_path(@thing, :foo => params[:foo])
          # redirect_to new_user_registration_path(@user, video: sign_up_params[:video], first_name: sign_up_params[:first_name])
          clean_up_passwords resource
          # respond_with resource
          render :new
        end
    else
      redirect_to root_path
    end

  end

    # def new
    #   @message = Message.new
    # end

    # def create
    #   if verify_recaptcha
    #     # @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    #     super
    #   else

    #     build_resource
    #     clean_up_passwords(resource)
    #     flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
    #     flash.delete :recaptcha_error
    #     render :new
    #   end
    # end

    # def file_dimensions
    #   dimensions = Paperclip::Geometry.from_file(photo.queued_for_write[:original].path)
    #   if ((dimensions.width < 250 && dimensions.height < 250 ) && (0.8 <= dimensions.width / dimensions || dimensions.width / dimensions <= 1.2))
    #       errors.add(:photo,'Image must be a square of at least 250px')
    #   end
    # end

    protected

    def after_sign_up_path_for(resource)
      new_startup_path
    end
    def after_update_path_for(resource)
      user_path(resource)
      # user_edit_path(resource)
    end
  end