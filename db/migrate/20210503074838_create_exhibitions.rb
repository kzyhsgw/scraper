class CreateExhibitions < ActiveRecord::Migration[6.0]
  def change
    create_table :exhibitions do |t|
      t.string :name
      t.string :title

      t.timestamps
    end
  end
end
