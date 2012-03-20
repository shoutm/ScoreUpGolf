class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.integer :golf_field_id
      t.datetime :competition_date
      t.integer :firsthalf_cource_id
      t.integer :secondhalf_cource_id
      t.integer :host_user_id

      t.timestamps
    end
  end
end
