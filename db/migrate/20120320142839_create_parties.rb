class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.integer :party_no
      t.integer :competition_id

      t.timestamps
    end
  end
end
