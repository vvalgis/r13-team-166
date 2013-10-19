class RenameFieldInProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.rename :owner_id, :user_id
    end
  end
end
