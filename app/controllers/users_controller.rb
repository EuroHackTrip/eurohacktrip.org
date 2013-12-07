def index
	@admin = Admin.all
end

def show
	@admin = Admin.find(params[:id])
end

def toggle_admin
    @admin = Admin.find(params[:id])
    @admin.is_admin = !@admin.is_admin
    @admin.save!
    redirect_to dashboard_index_path
end