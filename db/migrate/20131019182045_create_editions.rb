class CreateEditions < ActiveRecord::Migration
  def change
    create_table :editions, id: false do |t|
      t.references :document
      t.references :parent
      t.index [:document_id, :parent_id], unique: true
    end
  end
end
