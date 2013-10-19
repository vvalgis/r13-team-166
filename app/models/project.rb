class Project < ActiveRecord::Base
  has_many :documents

  def original
    documents.joins(:original).where(editions: {parent_id: nil}).first
  end

  after_create do
    documents.create(comment: 'original', lang: lang)
  end
end
