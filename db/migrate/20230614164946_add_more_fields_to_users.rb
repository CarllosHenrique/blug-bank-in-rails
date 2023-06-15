class AddMoreFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bio, :string, default: "Ola! estou usando o blugt Network."
    add_column :users, :password, :string
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
