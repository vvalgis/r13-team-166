class Project < ActiveRecord::Base
  has_many :documents

  attr_accessor :text

  def original
    documents.joins(:self_edition).where(self_edition: {parent_id: nil}).first
  end

  after_create do
    doc = documents.build(comment: 'original', lang: lang)
    doc.text = text
    doc.save
  end
end
