class Public::GasesController < ApplicationController

	def index
	  @sum = 0
      @gases = Gase.where(is_active: true)
      @items = Item.all

      @gas_request = GasRequest.new
      @test = GasRequest.find_by(gase_id: @gases.ids)
      # @gas_request = GasRequest.find_by(gase_id: @gases.ids)
      @cart_items = CartItem.all

      @gas_requests = GasRequest.all
      @total_amount = 0
      @total_gas_payment = 0
       @gas_requests.each do |gas_request|
       	@total_amount += (gas_request.gase.amount.to_i) * (gas_request.gas_amount.to_i)
       	@total_gas_payment += (gas_request.gase.price.to_i ) * (gas_request.gas_amount.to_i)
       end
      @perating_time = 0

	end

	def show
      # @cart_items = current_cart.cart_items
      @genres = Genre.all
      @gas_request = GasRequest.new
      # @cart_item.quantity += params[:quantity].to_i
	end



   def gase_params
      params.require(:gase).permit(:gase_id)
   end


   def gas_request_params
      params.require(:gas_request).permit(:group_id, :gase_id, :gas_amount)
   end



end
