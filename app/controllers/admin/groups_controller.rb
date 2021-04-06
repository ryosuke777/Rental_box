class Admin::GroupsController < ApplicationController

	def index
	  @groups = Group.all
	end

	def show
      @group = Group.find(params[:id])

      if Request.find_by(group_id: @group.id).present?
        @request = Request.find_by(group_id: @group.id)
        @order_items = OrderItem.where(request_id: @request.id)
        # @gas_requests = GasRequest.find_by(group_id: current_group.id)
        @order_gases = OrderGase.where(request_id: @request.id)
        # @gas_request.group_id = current_group.id
        @request_bring_in_equipments = RequestBringInEquipment.where(request_id: @request.id)
      else
        @request = Request.new
        @request.group = @group
        @order_items = OrderItem.where(request_id: @request.id)
        @order_gases = OrderGase.where(request_id: @request.id)
      end
	end

	def edit
      @group = Group.find(params[:id])
	end

	def update
	  @group = Group.find(params[:id])
	  	 if @group.update(group_params)
         redirect_to "/admin/groups/#{@group.id}"
         # admin_item_path(@item.id)
       else
         redirect_to "/public/about"
       end
	end

  def destroy
     @group = Group.find(params[:id])
     @request = Request.find_by(group_id: @group.id)
     @order_items = OrderItem.where(request_id: @request.id)
     @order_gases = OrderGase.where(request_id: @request.id)
     @request_bring_in_equipments =RequestBringInEquipment.where(request_id: @request.id)

     @order_items.destroy_all
     @order_gases.destroy_all
     @request_bring_in_equipments.destroy_all
     @request.destroy
     @group.destroy
     redirect_to admin_groups_path
  end

    private
    def group_params
      params.require(:group).permit(:email,:group_name,:group_name_kana,:representative_name,:representative_name_kana,:representative_telephone_number,:subdelegate_name,:subdelegate_name_kana,:subdelegate_telephone_number,:subdelegate_email)
    end

end
