class UsersController < ApplicationController
	def index
		@users = Admin.all
	end

	def show
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
end