class Public::RequestsController < ApplicationController
  def new
    @request = Request.new
    @request.group_id = current_group.id
  end

  def create
    @request = Request.new(request_params)
    if params[:request][:date_option] == '0'
      @request.date = 0
    elsif params[:request][:date_option] == '1'
      @request.date = 1
    elsif params[:request][:date_option] == '2'
      @request.date = 2
    end

    if Request.where(group_id: current_group.id).present?
      @request1 = Request.find_by(group_id: current_group.id)
      flash[:notice] = 'すでに申請されています。'
      @request.destroy
      redirect_to "/public/requests/#{@request1.id}"
    elsif params[:request][:date_option].nil? || params[:request][:item_for_sale].empty?
      flash[:notice] = '必要事項を入力してください'
      redirect_to new_public_request_path
    else
      @request.save
      if Time.new(2021, 7, 1) < @request.created_at # 締め切り日2021/6/30(水)
        flash[:notice] = '申請期間を過ぎています。来年のご参加をお待ちしております。'
        @request.destroy
        redirect_to '/public'
      else
        redirect_to '/public/items'
      end
    end

    @cart_items = CartItem.where(group_id: current_group.id)
  end

  def confirm
    # @requests = Request.all
    if Request.where(group_id: current_group.id).present?
      @requests = Request.where(group_id: current_group.id)
      @request = Request.find_by(group_id: current_group.id)
      # @request.group_id = current_group.id
      @cart_items = CartItem.where(group_id: current_group.id)
      # @gas_requests = GasRequest.find_by(group_id: current_group.id)
      @gas_requests = GasRequest.where(group_id: current_group.id)
      # @gas_request.group_id = current_group.id
      @bring_in_equipments = BringInEquipment.where(group_id: current_group.id)

      @sum = 0
      @cart_items.each do |cart_item|
        cart_item.item.add_price = 0 if @request.date == '10/23(土)' || @request.date == '10/24(日)'
        @sum += (cart_item.item.price.to_i + cart_item.item.add_price.to_i).floor * cart_item.item_amount
      end

      @gas_sum = 0
      @gas_requests.each do |gas_request|
        gas_request.destroy if gas_request.gas_amount == 0
        @gas_sum += gas_request.gase.price.floor * gas_request.gas_amount
      end

      @total_payment = @sum + @gas_sum
    else
      flash[:notice] = '販売品目、出店日が入力されていません。こちらから入力いただけます。'
      @gas_requests = GasRequest.where(group_id: current_group.id)
      @gas_requests.destroy_all
      redirect_to new_public_request_path
    end
  end

  def update
    @request = Request.find(params[:id])

    if @request.created_at == @request.updated_at

      @request.update(request_params)
      @cart_items = CartItem.where(group_id: current_group.id)
      @cart_items.each do |cart_item|
        @order_item = OrderItem.new
        @order_item.request_id = @request.id
        @order_item.item_id = cart_item.item_id
        @order_item.price = cart_item.item.price
        @order_item.price += cart_item.item.add_price if @request.date == '10/23(土),10/24(日)'
        @order_item.amount = cart_item.item_amount
        @order_item.save
        cart_item.destroy
      end

      @gas_requests = GasRequest.where(group_id: current_group.id)
      @gas_requests.each do |gas_request|
        @order_gase = OrderGase.new
        @order_gase.request_id = @request.id
        @order_gase.gase_id = gas_request.gase_id
        @order_gase.price = gas_request.gase.price
        @order_gase.amount = gas_request.gas_amount
        @order_gase.save
        gas_request.destroy
      end

      @bring_in_equipments = BringInEquipment.where(group_id: current_group.id)
      @bring_in_equipments.each do |bring_in_equipment|
        @request_bring_in_equipment = RequestBringInEquipment.new
        @request_bring_in_equipment.request_id = @request.id
        @request_bring_in_equipment.name = bring_in_equipment.name
        @request_bring_in_equipment.power_consumption = bring_in_equipment.power_consumption
        @request_bring_in_equipment.amount = bring_in_equipment.amount
        @request_bring_in_equipment.save
        bring_in_equipment.destroy
      end
      @group = current_group
      NotificationMailer.send_confirm_to_user(@group).deliver_now
      redirect_to public_requests_thanks_path
    else
      @request1 = Request.find_by(group_id: current_group.id)
      flash[:notice] = 'すでに申請されています。'
      @cart_items = CartItem.where(group_id: current_group.id)
      @cart_items.destroy_all
      @gas_requests = GasRequest.where(group_id: current_group.id)
      @gas_requests.destroy_all

      redirect_to "/public/requests/#{@request1.id}"
    end
  end

  def thanks; end

  def index
    @group = current_group
    @requests = Request.all
  end

  def show
    # @request = Request.find_by(group_id: current_group.id)
    if Request.where(group_id: current_group.id).present?

      @request = Request.find_by(group_id: current_group.id)
      @request_bring_in_equipments = RequestBringInEquipment.where(request_id: @request.id)
      @order_items = OrderItem.where(request_id: @request.id)
      # @gas_requests = GasRequest.find_by(group_id: current_group.id)
      @order_gases = OrderGase.where(request_id: @request.id)
    # @gas_request.group_id = current_group.id
    else
      flash[:notice] = '申請されていません。こちらから申請いただけます。'
      redirect_to new_public_request_path
    end
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
      cart_item.item.add_price = 0 if @request.date == '10/23(土)' || @request.date == '10/24(日)'
      @sum += (cart_item.item.price.to_i + cart_item.item.add_price.to_i).floor * cart_item.item_amount
    end

    @gas_sum = 0
    @gas_requests.each do |gas_request|
      @gas_sum += gas_request.gase.price.floor * gas_request.gas_amount
    end

    @total_payment = @sum + @gas_sum
  end

  private

  def request_params
    params.require(:request).permit(:group_id, :item_for_sale, :date, :total_payment, :image)
  end
end
