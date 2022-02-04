class OrderStatusMailer < ApplicationMailer
  def order_status
  	@user = params[:user]
  	@order = params[:order]
  	mail to: @user.email, subject: 'Order status'
  end
end