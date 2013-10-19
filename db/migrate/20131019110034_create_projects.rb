class CreateProjects < ActiveRecord::Migration
  def change
    drop_table :projects
    
    create_table :projects do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :lang

      t.timestamps
    end
  end
end
