class Public::BringInEquipmentsController < ApplicationController

	def index
	  @bring_in_equipment = BringInEquipment.new
	    if params[:power_consumption_option] == "0"
	      @bring_in_equipment.power_consumption = 0
	    elsif params[:power_consumption_option] == "1"
	      @bring_in_equipment.power_consumption = params[:power_consumption]
	    end

	  @bring_in_equipments = BringInEquipment.where(group_id: current_group.id)
	end

	def create
	  @bring_in_equipment = BringInEquipment.new(bring_in_equipment_params)
	  # @bring_in_equipment.group_id = current_group.id
# binding.pry

      @bring_in_equipment.save

	  redirect_to "/public/bring_in_equipments"
	end

	def edit
	  @bring_in_equipment = BringInEquipment.find(params[:id])
	end

	def update
	  @bring_in_equipment = BringInEquipment.find(params[:id])
	  @bring_in_equipment.update(bring_in_equipment_params)
      redirect_to public_bring_in_equipments_path
	end

	def destroy
	  @bring_in_equipment = BringInEquipment.find(params[:id])
	  @bring_in_equipment.destroy
      redirect_to public_bring_in_equipments_path
	end

    private
    def bring_in_equipment_params
      params.require(:bring_in_equipment).permit(:name, :power_consumption, :power_consumption_option, :amount)
    end


end
