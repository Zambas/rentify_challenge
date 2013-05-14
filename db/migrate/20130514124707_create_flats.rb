class CreateFlats < ActiveRecord::Migration
  def change
    create_table :flats do |t|
      t.string :name
      t.integer :bedroom_count
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
