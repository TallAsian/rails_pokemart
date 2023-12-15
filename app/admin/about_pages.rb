# app/admin/about_pages.rb
ActiveAdmin.register AboutPage do
  permit_params :content, :phone_number, :email, :address

  form do |f|
    f.inputs 'About Page' do
      f.input :content, as: :text
      f.input :phone_number
      f.input :email
      f.input :address
    end
    f.actions
  end
end
