class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_genres, only: %i[index new edit create update]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    @item.video_url = nil if params[:item][:video] == 0

    @item.manual_url = nil if params[:item][:manual] == 0

    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if params[:item][:video] == 0
      @item.video_url = nil
    else
      @item.video = 1
    end

    if params[:item][:manual] == 0
      @item.manual_url = nil
    else
      @item.manual = 1
    end

    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    # admin_item_path(@item.id)
    else
      render :edit
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def order_list
    @order_items = OrderItem.all
    @items = Item.all
    @gases = Gase.all
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :add_price, :power_consumption,
                                 :power_consumption_option, :fuel_economy, :fuel_economy_option, :video, :video_url, :manual, :manual_url, :genre_id)
  end

  def set_genres
    @genres = Genre.all
  end
end
