class CreateLots < ActiveRecord::Migration
  def change
    create_table :lots do |t|
      t.string  :group
      t.string  :half
      t.integer :number
      t.references :kid

      t.timestamps null: false
    end
  end
end
