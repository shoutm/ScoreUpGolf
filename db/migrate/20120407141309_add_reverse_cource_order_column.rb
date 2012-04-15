class AddReverseCourceOrderColumn < ActiveRecord::Migration
  def change
    add_column :parties, :reverse_cource_order, :boolean
  end
end
