class Project < ActiveRecord::Base
  has_many :documents

  attr_accessor :text

  def original
    documents.select('"documents".*').joins(:self_edition).where(editions: {parent_id: nil}).first
  end

  def text
    original ? original.text.to_s : @text.to_s
  end

  after_create do
    doc = documents.build(comment: 'original', lang: lang)
    doc.text = text
    doc.save
  end

  after_update do
    doc = original
    doc.text = @text
    doc.save
  end
end
