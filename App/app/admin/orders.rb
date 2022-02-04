ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :weight, :length, :width, :height, :distance, :origin_location, :destination_location, :price, :user_id, :aasm_state
  #
  # or
  #
  # permit_params do
  #   permitted = [:last_name, :first_name, :patronymic, :phone, :email, :weight, :length, :width, :height, :distance, :origin_location, :destination_location, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index title: "Orders (To change order status go to 'View' -> 'Change order status')"

  action_item :view, only: :show do
    link_to 'CHANGE ORDER STATUS', status_admin_orders_path
  end

  controller do
    def status
      @order = Order.find_by id: params[:id]
      @user = User.find_by id: @order.user_id
      @order.change_status!(@order)
      
      OrderStatusMailer.with(user: @user, order: @order).order_status.deliver_later

      redirect_to admin_order_path
    end
  end
end
