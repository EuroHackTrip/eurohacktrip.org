class UsersController < ApplicationController
  # before_action :user_approved, only: [:show, :index]
	before_action :is_admin, only: [:edit, :update]

	def index
		@message = Message.new
		@users = User.all
	end

	def show
		@message = Message.new
    # nick_names.each do |user|
    #  if user.split("=>")[0] == request.fullpath.split("/")[1]
    #    user_id = user.split("=>")[1]
    #    @user = User.where(id: user_id)
    #  end
    # end
		@user = User.friendly.find(params[:id])
	end

	def toggle_admin
	    @user = User.friendly.find(params[:id])
	    @user.is_admin = !@user.is_admin
	    @user.save!
	    redirect_to dashboard_index_path
	end

	def approve
	    @user = User.friendly.find(params[:id])
	    @user.approved = !@user.approved
	    @user.save!
	    redirect_to dashboard_index_path, notice: "User has been approved!"
  	end

  	def delete
  		@posts = Post.where(user_id:params[:id])
  		@posts.each do |post|
  			post.user_id = User.first.id
  			# post.published = post.published ? false : false
  			post.save!
  		end
  		User.find(params[:id]).delete
  		redirect_to dashboard_index_path, notice: "User has been deleted!"
  	end


  # GET /posts/1/edit
  def edit
    @user = User.friendly.find(params[:id])
  end


  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    @user = User.friendly.find(params[:id])
    # render json: @user
    # render json: params
    # render json: user_params
    # render json: params['user']

    respond_to do |format|
      if @user.update(user_params)
        @user.name = "#{@user.first_name}-#{@user.last_name}"
        @user.slug = @user.name.downcase
        @user.save!
        format.html { redirect_to user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_params
      params.require(:user).permit(:first_name, :last_name, :photo, :video, :about, :country, :city, :interest, :funding_campaign, :is_admin, :name, :slug)
  end

  # GET /users/api
  def api
    bunch = []
    results = User.where('first_name LIKE ? OR last_name LIKE ?', "%#{params['name']}%", "%#{params['name']}%")
    
    results.each do |user|
      data = {}
      data['name'] = user['first_name'] + ' ' + user['last_name']
      data['id'] = user['id']
      bunch << data
    end
    render json: bunch
  end
  private

    def is_admin
      unless current_user && current_user.is_admin
        flash[:error] = "You have no rights to access that!" 
        redirect_to root_path
      end
    end
end