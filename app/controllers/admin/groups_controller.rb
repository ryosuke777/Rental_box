class Admin::GroupsController < ApplicationController

	def index
	  @groups = Group.all
	end

	def show
      @group = Group.find(params[:id])
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

    private
    def group_params
      params.require(:group).permit(:email,:group_name,:group_name_kana,:representative_name,:representative_name_kana,:representative_telephone_number,:subdelegate_name,:subdelegate_name_kana,:subdelegate_telephone_number,:subdelegate_email)
    end

end
