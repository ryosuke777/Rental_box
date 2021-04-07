class Public::GasRequestsController < ApplicationController
  def index
    @bring_in_equipments = BringInEquipment.where(group_id: current_group.id)
    @cart_items = CartItem.where(group_id: current_group.id)

    @sum_of_bring_in_equipments = 0
    @bring_in_equipments.each do |bring_in_equipment|
      @sum_of_bring_in_equipments += bring_in_equipment.power_consumption.to_i.floor * bring_in_equipment.amount.to_i
    end

    @sum_of_cart_items = 0
    @cart_items.each do |cart_item|
      @sum_of_cart_items += cart_item.item.power_consumption.to_i.floor * cart_item.item_amount.to_i
    end

    @total_power = 0
    @total_power = @sum_of_cart_items.to_i + @sum_of_bring_in_equipments

    if @total_power > 2000
      flash[:notice] = '合計電力が2000 Wを超えています。'
      redirect_to '/public/cart_items'
    else
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
        @total_amount += gas_request.gase.amount.to_i * gas_request.gas_amount.to_i
        @total_gas_payment += gas_request.gase.price.to_i * gas_request.gas_amount.to_i
      end
      @operating_time = 0
    end
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
      redirect_to '/public/gas_requests'
    else
      @gas_request.save
      redirect_to '/public/gas_requests'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @gas_request = GasRequest.find(params[:id])

    if params[:gas_request][:gas_amount].to_i == 0
      @gas_request.destroy
      redirect_to '/public/gas_requests'
    else
      @gas_request.update(gas_request_params)
      redirect_to '/public/gas_requests'
    end
  end

  private

  def gase_params
    params.require(:gase).permit(:gase_id)
  end

  def gas_request_params
    params.require(:gas_request).permit(:group_id, :gase_id, :gas_amount)
  end
end
