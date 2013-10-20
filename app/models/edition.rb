class Edition < ActiveRecord::Base
  belongs_to :document
  belongs_to :original, class_name: 'Document', foreign_key: :parent_id
end
