class NotificationMailer < ActionMailer::Base
  default from: 'no.reply.rental.box@gmail.com'

  def send_confirm_to_user(user)
    @group = user

    @request = Request.find_by(group_id: @group.id)
    @order_items = OrderItem.where(request_id: @request.id)
    @order_gases = OrderGase.where(request_id: @request.id)

    mail(
      subject: '模擬店出店申請が完了しました。', # メールのタイトル
      to: @group.email # 宛先
    ) do |format|
      format.text
    end
  end
end
