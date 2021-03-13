class Public::RequestsController < ApplicationController


	def new
	 @request = Request.new
   @request.group_id = current_group.id
	end


  def create
   @request = Request.new(request_params)
     if  params[:request][:date_option] == "0"
          @request.date = 0
     elsif params[:request][:date_option] == "1"
          @request.date = 1
     elsif params[:request][:date_option] == "2"
          @request.date = 2
     end

     if Request.where(group_id: current_group.id).present?
      @request1 = Request.find_by(group_id: current_group.id)
       flash[:notice] = "すでに申請されています。"
       redirect_to "/public/requests/#{@request1.id}"
     else
       @request.save
       redirect_to "/public/items"
     end
   @cart_items = CartItem.where(group_id: current_group.id)
  end


	def confirm
   # @requests = Request.all
   @requests = Request.where(group_id: current_group.id)
   @request = Request.find_by(group_id: current_group.id)
   # @request.group_id = current_group.id
   @cart_items = CartItem.where(group_id: current_group.id)
   # @gas_requests = GasRequest.find_by(group_id: current_group.id)
   @gas_requests = GasRequest.where(group_id: current_group.id)
   # @gas_request.group_id = current_group.id

   @sum = 0
   @cart_items.each do |cart_item|
      if @request.date == "10/23(土)"||@request.date == "10/24(日)"
       cart_item.item.add_price = 0
      end
     @sum += ((cart_item.item.price.to_i*1.10 + cart_item.item.add_price.to_i*1.10).floor)*cart_item.item_amount
   end

   @gas_sum = 0
    @gas_requests.each do |gas_request|
      @gas_sum += (gas_request.gase.price * 1.10).floor * (gas_request.gas_amount)
    end

  @total_payment = @sum + @gas_sum

	end


  def update
    @request = Request.find(params[:id])
    if @request.update(request_params)
      redirect_to public_requests_thanks_path
    end
  end

	def thanks
	end

	def index
      @group = current_group
      @requests = Request.all
	end

	def show
    # @request = Request.find_by(group_id: current_group.id)

      @request = Request.find_by(group_id: current_group.id)
      @cart_items = CartItem.where(group_id: current_group.id)
      # @gas_requests = GasRequest.find_by(group_id: current_group.id)
      @gas_requests = GasRequest.where(group_id: current_group.id)
      # @gas_request.group_id = current_group.id

      @sum = 0
        @cart_items.each do |cart_item|
        if @request.date == "10/23(土)"||@request.date == "10/24(日)"
         cart_item.item.add_price = 0
        end
        @sum += ((cart_item.item.price.to_i*1.10 + cart_item.item.add_price.to_i*1.10).floor)*cart_item.item_amount
      end

      @gas_sum = 0
       @gas_requests.each do |gas_request|
         @gas_sum += (gas_request.gase.price * 1.10).floor * (gas_request.gas_amount)
       end

     @total_payment = @sum + @gas_sum
	end

  def edit
      @request = Request.find_by(group_id: current_group.id)
      @cart_items = CartItem.where(group_id: current_group.id)
      # @gas_requests = GasRequest.find_by(group_id: current_group.id)
      @gas_requests = GasRequest.where(group_id: current_group.id)
      # @gas_request.group_id = current_group.id

      @bring_in_equipments = BringInEquipment.where(group_id: current_group.id)

      @sum = 0
        @cart_items.each do |cart_item|
          if @request.date == "10/23(土)"||@request.date == "10/24(日)"
         　　cart_item.item.add_price = 0
          end
          @sum += ((cart_item.item.price.to_i*1.10 + cart_item.item.add_price.to_i*1.10).floor)*cart_item.item_amount
        end

      @gas_sum = 0
      @gas_requests.each do |gas_request|
         @gas_sum += (gas_request.gase.price * 1.10).floor * (gas_request.gas_amount)
      end

     @total_payment = @sum + @gas_sum
  end


    private
    def request_params
      params.require(:request).permit(:group_id, :item_for_sale, :date, :total_payment)
    end


end
