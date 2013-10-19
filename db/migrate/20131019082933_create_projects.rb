class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :owner_id
      t.string :base_language

      t.timestamps
    end
  end
end
