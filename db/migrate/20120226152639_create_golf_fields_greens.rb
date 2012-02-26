class CreateGolfFieldsGreens < ActiveRecord::Migration
  def change
    create_table :golf_fields_greens do |t|
      t.integer :golf_field_id
      t.integer :green_id

      t.timestamps
    end
  end
end
