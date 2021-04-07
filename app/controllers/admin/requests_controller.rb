class Admin::RequestsController < ApplicationController
  def edit
    @group = Group.find(params[:id])
    @request = Request.find_by(group_id: @group.id)
    @order_items = OrderItem.where(request_id: @request.id)
    # @gas_requests = GasRequest.find_by(group_id: current_group.id)
    @order_gases = OrderGase.where(request_id: @request.id)
    # @gas_request.group_id = current_group.id
    @request_bring_in_equipments = RequestBringInEquipment.where(request_id: @request.id)
  end

  def update
    @request = Request.find(params[:id])
    if params[:request][:date_option] == '0'
      @request.date = 0
    elsif params[:request][:date_option] == '1'
      @request.date = 1
    elsif params[:request][:date_option] == '2'
      @request.date = 2
    end
    @order_items = OrderItem.where(request_id: @request.id)
    @order_gases = OrderGase.where(request_id: @request.id)

    @sum = 0
    @order_items.each do |order_item|
      order_item.item.add_price = 0 if @request.date == '10/23(土)' || @request.date == '10/24(日)'
      @sum += (order_item.item.price.to_i * 1.10 + order_item.item.add_price.to_i * 1.10).floor * order_item.amount
    end

    @gas_sum = 0
    @order_gases.each do |order_gase|
      @gas_sum += (order_gase.gase.price * 1.10).floor * order_gase.amount
    end

    @total_payment = @sum + @gas_sum
    @request.total_payment = @total_payment
    # binding.pry
    @request.save
    redirect_to admin_group_path(@request.group_id)
  end

  def change_order_item_amount
    order_item = OrderItem.find(params[:id])
    @request = Request.find_by(id: order_item.request_id)
    order_item.amount = params[:order_item][:amount]

    order_item.update(order_item_params)

    order_items = OrderItem.where(request_id: @request.id)
    order_gases = OrderGase.where(request_id: @request.id)

    @sum = 0
    order_items.each do |order_item2|
      order_item2.item.add_price = 0 if @request.date == '10/23(土)' || @request.date == '10/24(日)'
      @sum += (order_item2.item.price.to_i * 1.10 + order_item2.item.add_price.to_i * 1.10).floor * order_item2.amount
    end

    @gas_sum = 0
    order_gases.each do |order_gase|
      @gas_sum += (order_gase.gase.price * 1.10).floor * order_gase.amount
    end

    @request.total_payment = @sum + @gas_sum
    # binding.pry
    @request.save

    redirect_to admin_group_path(@request.group_id)
  end

  def change_order_gas_amount
    order_gase = OrderGase.find(params[:id])
    @request = Request.find_by(id: order_gase.request_id)
    order_gase.amount = params[:order_gase][:amount]

    order_gase.update(order_gas_params)

    order_items = OrderItem.where(request_id: @request.id)
    order_gases = OrderGase.where(request_id: @request.id)

    @sum = 0
    order_items.each do |order_item|
      order_item.item.add_price = 0 if @request.date == '10/23(土)' || @request.date == '10/24(日)'
      @sum += (order_item.item.price.to_i * 1.10 + order_item.item.add_price.to_i * 1.10).floor * order_item.amount
    end

    @gas_sum = 0
    order_gases.each do |order_gase2|
      @gas_sum += (order_gase2.gase.price * 1.10).floor * order_gase2.amount
    end

    @request.total_payment = @sum + @gas_sum
    # binding.pry
    @request.save

    redirect_to admin_group_path(@request.group_id)
  end

  # order_item削除処理
  def destroy
    @order_item = OrderItem.find(params[:id])
    @request = Request.find_by(id: @order_item.request_id)
    @order_item.destroy

    @order_items = OrderItem.where(request_id: @request.id)
    @order_gases = OrderGase.where(request_id: @request.id)

    @sum = 0
    @order_items.each do |order_item|
      order_item.item.add_price = 0 if @request.date == '10/23(土)' || @request.date == '10/24(日)'
      @sum += (order_item.item.price.to_i * 1.10 + order_item.item.add_price.to_i * 1.10).floor * order_item.amount
    end

    @gas_sum = 0
    @order_gases.each do |order_gase|
      @gas_sum += (order_gase.gase.price * 1.10).floor * order_gase.amount
    end

    @request.total_payment = @sum + @gas_sum
    # binding.pry
    @request.save

    redirect_to admin_group_path(@request.group_id)
    # binding.pry
  end

  # order_gase削除処理
  def destroy_order_gas
    @order_gase = OrderGase.find(params[:id])
    @request = Request.find_by(id: @order_gase.request_id)
    @order_gase.destroy

    @order_items = OrderItem.where(request_id: @request.id)
    @order_gases = OrderGase.where(request_id: @request.id)

    @sum = 0
    @order_items.each do |order_item|
      order_item.item.add_price = 0 if @request.date == '10/23(土)' || @request.date == '10/24(日)'
      @sum += (order_item.item.price.to_i * 1.10 + order_item.item.add_price.to_i * 1.10).floor * order_item.amount
    end

    @gas_sum = 0
    @order_gases.each do |order_gase|
      @gas_sum += (order_gase.gase.price * 1.10).floor * order_gase.amount
    end

    @request.total_payment = @sum + @gas_sum
    # binding.pry
    @request.save

    redirect_to admin_group_path(@request.group_id)
  end

  private

  def request_params
    params.require(:request).permit(:group_id, :item_for_sale, :date, :total_payment, :image)
  end

  def order_item_params
    params.require(:order_item).permit(:id, :item_id, :request_id, :price, :amount)
  end

  def order_gas_params
    params.require(:order_gase).permit(:id, :gase_id, :request_id, :price, :amount)
  end
end
