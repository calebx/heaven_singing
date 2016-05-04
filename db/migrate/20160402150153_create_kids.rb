class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string :name
      t.string :school
      t.string :who
      t.string :phone
      t.string :district
      t.string :song_a
      t.string :song_b
      t.string :category
      t.string :group
      t.string :half

      t.timestamps null: false
    end
  end
end
