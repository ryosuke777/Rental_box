class Public::ItemsController < ApplicationController


	def index
        @genres = Genre.all
        @items = Item.all
        if @request == nil
        @request = Request.new
        else
        @request = Request.find_by(group_id: current_group.id)
        end
	end

      def search
        @genres = Genre.all
        @genre = Genre.find(params[:id])
        @items = Item.where(genre: @genre.id)
        if @request == nil
        @request = Request.new
        else
        @request = Request.find_by(group_id: current_group.id)
        end
      end

	def show
      # @cart_items = current_cart.cart_items
        @genres = Genre.all
        @item = Item.find(params[:id])
      # binding.pry
        @cart_item = CartItem.new
      # @cart_item.quantity += params[:quantity].to_i
        if @request == nil
        @request = Request.new
        else
        @request = Request.find_by(group_id: current_group.id)
        end
	end


end
