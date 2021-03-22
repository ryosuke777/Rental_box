class Admin::ItemsController < ApplicationController
	  before_action :authenticate_admin!
	  before_action :set_genres, only: [:index, :new, :edit, :create,:update]


	def index
     @items = Item.all
	end

	def new
	  @item = Item.new
	end

	def create
	  @item = Item.new(item_params)

		if  params[:item][:video] == 0
		  @item.video_url = nil
		elsif params[:item][:video] == 1
          @item.video_url = params[:video_url]
		end


		if  params[:item][:manual] == 0
		  @item.manual_url = nil
		elsif params[:item][:manual] == 1
          @item.manual_url = params[:manual_url]
		end

	    if params[:item][:power_consumption_option] == 0
	      @item.power_consumption = 0.to_i
	    elsif params[:item][:power_consumption_option] == 1
	      @item.power_consumption = params[:power_consumption].to_i
	    end


	    if params[:item][:fuel_economy_option] == 0
	      @item.fuel_economy = 0.to_f
	    elsif params[:item][:fuel_economy_option] == 1
	      @item.fuel_economy = params[:fuel_economy].to_f
	    end

	  if @item.save
	  	redirect_to admin_item_path(@item.id)
	  else
	  	redirect_to "/public/about"
	  end



	end

	def edit
	   @item = Item.find(params[:id])
	end

	def update
	   @item = Item.find(params[:id])


		if  @item.video == 0
		  @item.video_url = nil
		elsif @item.video == 1
          @item.video_url = params[:video_url]
		end


		if  @item.manual == 0
		  @item.manual_url = nil
		elsif @item.manual == 1
          @item.manual_url = params[:manual_url]
		end

	    if @item.power_consumption_option == 0
	      @item.power_consumption = 0.to_i
	    elsif @item.power_consumption_option == 1
	      @item.power_consumption = params[:power_consumption].to_i
	    end


	    if @item.fuel_economy_option == 0
	      @item.fuel_economy = 0.to_f
	    elsif @item.fuel_economy_option == 1
	      @item.fuel_economy = params[:fuel_economy].to_f
	    end


	     if @item.save
           redirect_to admin_item_path(@item.id)
           # admin_item_path(@item.id)
         else
           render :edit
         end
	end

	def show
	   @item = Item.find(params[:id])
	end

	def destroy
		@item = Item.find(params[:id])
		@item.destroy
		redirect_to admin_items_path
	end

    private
    def item_params
      params.require(:item).permit(:name, :image, :introduction, :price, :add_price, :power_consumption, :power_consumption_option, :fuel_economy, :fuel_economy_option, :video, :video_url, :manual, :manual_url, :genre_id)
    end

    def set_genres
      @genres = Genre.all
    end
end
