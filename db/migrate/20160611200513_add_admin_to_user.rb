class AddAdminToUser < ActiveRecord::Migration
  def change
  	add_column :users, :admin, :booolean, default: false
  end
end
