class AddMeasurementToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :measurement, :string
  end
end
