class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string :name
      t.string :phone
      t.string :school
      t.string :grade
      t.string :song
      t.string :group
      t.integer :draw
      t.boolean :drawed, default: false

      t.timestamps null: false
    end
  end
end
