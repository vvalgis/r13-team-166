class Document < ActiveRecord::Base
  belongs_to :project
  has_many :editions, foreign_key: 'parent_id'
  has_one :original, class_name: 'Edition', foreign_key: 'document_id'


  def parent_id(parent_id = nil)
    return @parent_id if parent_id.nil?
    @parent_id = parent_id 
    self
  end

  def parent_id=(parent_id)
    @parent_id = parent_id
  end

  after_create do
    options = {document_id: self.id}
    options[:parent_id] = @parent_id if @parent_id

    Edition.create(options)
  end
end
