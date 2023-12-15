class AddDetailsToAboutPages < ActiveRecord::Migration[7.1]
  def change
    add_column :about_pages, :phone_number, :string
    add_column :about_pages, :email, :string
    add_column :about_pages, :address, :string
  end
end
