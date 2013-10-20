class Document < ActiveRecord::Base
  belongs_to :project
  has_many :editions, foreign_key: 'parent_id'
  has_one :original, class_name: 'Edition', foreign_key: 'document_id'

  attr_accessor :parent_id
  attr_accessor :text

  after_create do
    options = {document_id: self.id}
    options[:parent_id] = parent_id if parent_id

    Edition.create(options)
  end

  after_save :update_file

  def filename
    "#{project.user_id}_#{project.id}/#{id}.md"
  end

  def text
    @text ||= Scriba::Text.find(filename)
  end

  def html
    Scriba.markdown_text_to_html(text.to_s)
  end

  private

  def update_file
    Scriba::Text.new(@text, filename).save
  end
end
