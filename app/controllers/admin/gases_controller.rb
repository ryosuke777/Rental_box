class Admin::GasesController < ApplicationController


	def create
		@gase = Gase.new(gase_params)
		if @gase.save
		  redirect_to "/admin/gases"
	    end
	end

	def index
		@gase = Gase.new
		@gases = Gase.all
	end

	def edit
		@gase = Gase.find(params[:id])
	end

	def update
		@gase = Gase.find(params[:id])
		@gase.update(gase_params)
		redirect_to admin_gases_path
	end


  private
  def gase_params
      params.require(:gase).permit(:name, :amount, :price, :is_active)
  end

end
