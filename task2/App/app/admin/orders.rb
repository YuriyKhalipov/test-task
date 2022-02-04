ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :last_name, :first_name, :patronymic, :phone, :email, :weight, :length, :width, :height, :distance, :origin_location, :destination_location, :price
  #
  # or
  #
  # permit_params do
  #   permitted = [:last_name, :first_name, :patronymic, :phone, :email, :weight, :length, :width, :height, :distance, :origin_location, :destination_location, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
