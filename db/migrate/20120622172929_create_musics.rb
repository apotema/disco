class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :name
      t.references :album

      t.timestamps
    end
    add_index :musics, :album_id
  end
end
