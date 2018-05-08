class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.belongs_to :user, index: true
      t.string :path
      t.text :description
      t.string :location
      t.integer :likes
      t.timestamps
    end
  end
end
