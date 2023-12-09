ActiveAdmin.register Category do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :cat_name

  filter :cat_name, label: 'Category Name', as: :string
  filter :created_at, label: 'Created At', as: :date_range
  filter :updated_at, label: 'Updated At', as: :date_range

  show title: proc { |category| category.cat_name } do
    attributes_table do
      row :cat_name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  form do |f|
    f.inputs 'Category Details' do
      f.input :cat_name
    end
    f.actions
  end
  # or
  #
  # permit_params do
  #   permitted = [:cat_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
