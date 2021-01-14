class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.integer :requester_id
      t.integer :donor_id

      t.timestamps
    end
  end
end
