class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
    	t.string :nane, :null => false
    	t.string :description
    	t.string :owner
    	t.timestamps
    end
  end
end
