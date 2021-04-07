class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.all
    if group_signed_in?
      if Request.where(group_id: current_group.id).present?
        @request = Request.find_by(group_id: current_group.id)
      else
        flash[:notice] = '必要事項を入力してください'
        redirect_to new_public_request_path
      end
    else
      @request = Request.new
    end
  end

  def search
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @items = Item.where(genre: @genre.id)
    @request = if group_signed_in?
                 Request.find_by(group_id: current_group.id)
               else
                 Request.new
               end
  end

  def show
    # @cart_items = current_cart.cart_items
    @genres = Genre.all
    @item = Item.find(params[:id])
    # binding.pry
    @cart_item = CartItem.new
    # @cart_item.quantity += params[:quantity].to_i
    @request = if group_signed_in?
                 Request.find_by(group_id: current_group.id)
               else
                 Request.new
               end
  end
end
