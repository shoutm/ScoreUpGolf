class CreateGolfCources < ActiveRecord::Migration
  def change
    create_table :golf_cources do |t|
      t.string :name
      t.integer :golf_field_id

      t.timestamps
    end
  end
end
