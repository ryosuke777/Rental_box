class Public::ItemsController < ApplicationController


	def index
      @genres = Genre.all
      @items = Item.all
	end

      def search
      @genres = Genre.all
      @genre = Genre.find(params[:id])
      @items = Item.where(genre: @genre.id)
      end

	def show
      # @cart_items = current_cart.cart_items
      @genres = Genre.all
      @item = Item.find(params[:id])
      # binding.pry
      @cart_item = CartItem.new
      # @cart_item.quantity += params[:quantity].to_i
	end


end
