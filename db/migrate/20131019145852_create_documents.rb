class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :project, index: true
      t.string :comment
      t.string :lang, length: 2

      t.timestamps
    end
  end
end
