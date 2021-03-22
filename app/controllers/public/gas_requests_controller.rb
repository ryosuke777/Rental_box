class Public::GasRequestsController < ApplicationController


	def index
	  @sum = 0
      @gases = Gase.where(is_active: true)
      @items = Item.all

      @gas_request = GasRequest.new
      # @gas_request = GasRequest.find_by(gase_id: @gases.ids)
      @cart_items = CartItem.where(group_id: current_group.id)

      @gas_requests = GasRequest.where(group_id: current_group.id)
      @total_amount = 0
      @total_gas_payment = 0
       @gas_requests.each do |gas_request|
       	@total_amount += (gas_request.gase.amount.to_i) * (gas_request.gas_amount.to_i)
       	@total_gas_payment += (gas_request.gase.price.to_i ) * (gas_request.gas_amount.to_i)
       end
      @operating_time = 0

	end



	def create

	    @current_gas_requests = GasRequest.find_by(group_id: current_group.id, gase_id: params[:gas_request][:gase_id])
	    if @current_gas_request.nil?
	      @gas_request = current_group.gas_requests.new(gas_request_params)
	    else
	      @gas_request = @current_gas_requests
	      @gas_request.gas_amount = params[:gas_request][:gas_amount].to_i
	    end

	    if current_group.gas_requests.find_by(gase_id: params[:gas_request][:gase_id]).present?
	       @gas_request = @current_gas_requests
	       @gas_request.gas_amount = params[:gas_request][:gas_amount].to_i
	    end



	    if params[:gas_request][:gas_amount].to_i == 0
	      @gas_request.destroy
	      redirect_to "/public/gas_requests"
	    else
		  @gas_request.save
		  redirect_to "/public/gas_requests"
	    end



	end


	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		@gas_request = GasRequest.find(params[:id])

	    if params[:gas_request][:gas_amount].to_i == 0
	      @gas_request.destroy
	      redirect_to "/public/gas_requests"
	    else
	      @gas_request.update(gas_request_params)
	      redirect_to "/public/gas_requests"
	    end

	end





   def gase_params
      params.require(:gase).permit(:gase_id)
   end



   def gas_request_params
      params.require(:gas_request).permit(:group_id, :gase_id, :gas_amount)
   end




end
