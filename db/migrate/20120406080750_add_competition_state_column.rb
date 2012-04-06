class AddCompetitionStateColumn < ActiveRecord::Migration
  def change
    add_column :competitions, :state, :integer
  end
end
