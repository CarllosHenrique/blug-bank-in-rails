class AddMoneyAsDefaultInUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :cash
    add_column :users, :cash, :float, default: 1000.0
  end
end
