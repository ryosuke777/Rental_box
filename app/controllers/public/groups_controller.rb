class Public::GroupsController < ApplicationController
  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to public_group_path
  end

  def unsubscribe; end

  def withdraw
    @group = current_group
    @group.is_deleted = true
    @group.save
    reset_session
    flash[:notice] = 'ありがとうございました。またのご利用を心よりお待ちしております。'
    redirect_to '/public'
  end

  def group_params
    params.require(:group).permit(:email, :group_name, :group_name_kana, :representative_name, :representative_name_kana,
                                  :representative_telephone_number, :subdelegate_name, :subdelegate_name_kana, :subdelegate_telephone_number, :subdelegate_email)
  end
end
