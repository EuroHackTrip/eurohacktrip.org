class UsersController < ApplicationController
	def index
		@message = Message.new
		@users = Admin.all
	end

	def show
		@message = Message.new
		# nick_names.each do |user|
	 #      if user.split("=>")[0] == request.fullpath.split("/")[1]
	 #        user_id = user.split("=>")[1]
	 #        @user = Admin.where(id: user_id)
	 #      end
  #   	end
		@user = Admin.find(params[:id])
	end

	def toggle_admin
	    @admin = Admin.find(params[:id])
	    @admin.is_admin = !@admin.is_admin
	    @admin.save!
	    redirect_to dashboard_index_path
	end

	def approve
	    @admin = Admin.find(params[:id])
	    @admin.approved = !@admin.approved
	    @admin.save!
	    redirect_to dashboard_index_path, notice: "User has been approved!"
  	end

  	def delete
  		Admin.find(params[:id]).delete
  		redirect_to dashboard_index_path, notice: "User has been deleted!"
  	end
end