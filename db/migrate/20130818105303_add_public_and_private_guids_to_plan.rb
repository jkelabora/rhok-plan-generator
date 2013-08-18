class AddPublicAndPrivateGuidsToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :private_guid, :string, :nullable => false
    add_column :plans, :public_guid,  :string, :nullable => false
  end
end
