class AddAttributesToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :quantity, :integer, default: 1
  end
end
