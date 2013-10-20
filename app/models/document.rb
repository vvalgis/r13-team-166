class Document < ActiveRecord::Base
  
  belongs_to :project
  
  has_many :sub_editions, class_name: 'Edition', foreign_key: 'parent_id'
  has_many :editions, class_name: 'Document', through: :sub_editions, foreign_key: 'document_id'

  has_one :self_edition, class_name: 'Edition', foreign_key: 'document_id'
  has_one :original, class_name: 'Document', through: :self_edition, foreign_key: 'parent_id'

  attr_accessor :parent_id
  attr_accessor :text

  after_create do
    options = {document_id: self.id}
    options[:parent_id] = parent_id if parent_id

    Edition.create(options)
  end

  after_save :update_file

  def is_original?
    self_edition.parent_id.nil?
  end

  def filename
    "#{project.user_id}_#{project.id}/#{id}.md"
  end

  def text
    @text ||= Scriba::Text.find(filename)
  end

  def to_html
    Scriba.markdown_text_to_html(text.to_s)
  end

  # def new_edition
  #   new_doc = project.documents.build(lang: lang, comment: "translation to #{lang}")
  #   new_doc.parent_id = id
  #   new_doc.text = text.to_s
  #   new_doc.save
  #   new_doc
  # end

  private

  def update_file
    Scriba::Text.new(@text, filename).save
  end
end
