class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :name
      t.text :body
      t.string :image_path

      t.timestamps null: false
    end
  end
end
