class Public::BringInEquipmentsController < ApplicationController
  def index
    @bring_in_equipment = BringInEquipment.new
    @bring_in_equipments = BringInEquipment.where(group_id: current_group.id)
  end

  def create
    @bring_in_equipment = BringInEquipment.new(bring_in_equipment_params)
    # @bring_in_equipment.group_id = current_group.id

    if @bring_in_equipment.save
      redirect_to '/public/bring_in_equipments'
    else
      @bring_in_equipments = BringInEquipment.where(group_id: current_group.id)
      render 'index'
    end
  end

  def edit
    @bring_in_equipment = BringInEquipment.find(params[:id])
  end

  def update
    @bring_in_equipment = BringInEquipment.find(params[:id])
    if @bring_in_equipment.update(bring_in_equipment_params)
      redirect_to public_bring_in_equipments_path
    else
      render 'edit'
    end
  end

  def destroy
    @bring_in_equipment = BringInEquipment.find(params[:id])
    @bring_in_equipment.destroy
    redirect_to public_bring_in_equipments_path
  end

  private

  def bring_in_equipment_params
    params.require(:bring_in_equipment).permit(:name, :power_consumption, :power_consumption_option, :amount,
                                               :group_id)
  end
end
