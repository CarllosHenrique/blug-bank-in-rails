class AddCashToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cash, :float, default: 0.0
  end
end
