ActiveAdmin.register Product do
  permit_params :prod_name, :cost, :category_id, :image, :description

  filter :category, collection: -> { Category.pluck(:cat_name, :id) }, label: 'Category'
  filter :prod_name, label: 'Product Name', as: :string
  filter :cost, label: 'Cost', as: :numeric
  filter :created_at, label: 'Created At', as: :date_range
  filter :updated_at, label: 'Updated At', as: :date_range

  index do
    selectable_column
    id_column
    column :prod_name
    column :description
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
      row :description
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
    f.semantic_errors
    f.inputs 'Product Details' do
      f.input :category, as: :select, collection: Category.all.map { |c| [c.cat_name, c.id] }, include_blank: 'Select a Category'
      f.input :prod_name
      f.input :cost
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end
end
