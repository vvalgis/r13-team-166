class Project < ActiveRecord::Base
  has_many :documents

  attr_accessor :text

  def original
    documents.joins(:original).where(editions: {parent_id: nil}).first
  end

  after_create do
    doc = documents.build(comment: 'original', lang: lang)
    doc.text = text
    doc.save
  end
end
