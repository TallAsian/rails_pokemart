ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :prod_name, :cost, :category_id, :image
  
  filter :category, collection: -> { Category.pluck(:cat_name, :id) }, label: 'Category'
  filter :prod_name, label: 'Product Name', as: :string
  filter :cost, label: 'Cost', as: :numeric
  filter :created_at, label: 'Created At', as: :date_range
  filter :updated_at, label: 'Updated At', as: :date_range


  index do
    selectable_column
    id_column
    column :prod_name
    column :cost
    column :category do |product|
      link_to product.category.cat_name, admin_category_path(product.category) if product.category
    end
    column :created_at
    column :updated_at
    actions
  end

  show title: proc { |product| product.prod_name } do
    attributes_table do
      row :prod_name
      row :cost
      row :category do |product|
        link_to product.category.cat_name, admin_category_path(product.category) if product.category
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  
  form do |f|
    f.inputs 'Product Details' do
      f.input :category, as: :select, collection: Category.all.map { |c| [c.cat_name, c.id] }, include_blank: 'Select a Category'
      f.input :prod_name
      f.input :cost
    end
    f.actions
  end

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:prod_name, :cost, :categories_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
