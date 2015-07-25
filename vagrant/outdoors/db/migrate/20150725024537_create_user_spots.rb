class CreateUserSpots < ActiveRecord::Migration
  def change
    create_table :user_spots do |t|
      t.references :user, index: true, foreign_key: true
      t.references :spot, index: true, foreign_key: true
      t.integer :judgment

      t.timestamps null: false
    end
  end
end
