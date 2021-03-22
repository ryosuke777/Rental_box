class Public::CartItemsController < ApplicationController


	def index
	  @cart_items = CartItem.where(group_id: current_group.id)
    @bring_in_equipments = BringInEquipment.where(group_id: current_group.id)
    @sum = 0
    @sum_of_cart_items = 0
    @sum_of_bring_in_equipments = 0
    @total_power = 0
	end


  def create

    @current_cart_items = CartItem.find_by(group_id: current_group.id, item_id: params[:cart_item][:item_id])

    if @current_cart_item.nil?
      @cart_item = current_group.cart_items.new(cart_items_params)
    else
      @cart_item = @current_cart_items
      @cart_item.item_amount += params[:cart_item][:item_amount].to_i
    end

    if current_group.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
       @cart_item = @current_cart_items
       @cart_item.item_amount += params[:cart_item][:item_amount].to_i
    end

    if @cart_item.item_amount == 0
      @cart_item.destroy
    end


   @request = Request.find_by(group_id: current_group.id)
# binding.pry
   if @request.date == "10/23(土)"||@request.date == "10/24(日)"
     @cart_item.item.add_price = 0
   end

# binding.pry

      @cart_item.save
      redirect_to "/public/cart_items"
  end

	def update

    cart_item = CartItem.find(params[:id])

    if params[:cart_item][:item_amount].to_i == 0
      cart_item.destroy
    else
      cart_item.update(cart_items_params)
    end

    redirect_to public_cart_items_path
	end

	def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to public_cart_items_path
	end

	def delete_all
    @cart_items = CartItem.where(group_id: current_group.id)
    @cart_items.destroy_all
    redirect_to public_cart_items_path
	end

	def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :genre_id, :is_active)
  end


  private

   def cart_items_params
      params.require(:cart_item).permit(:item_amount, :item_id)
   end




end
