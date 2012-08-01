class AddPartnerColumn < ActiveRecord::Migration
  def up
    add_column :users, :partner, :boolean
  end

  def down
    remove_column :users, :partner
  end
end
