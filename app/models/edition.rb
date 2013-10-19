class Edition < ActiveRecord::Base
  belongs_to :document
  # has_many :children, class_name: 'Edition', foreign_key: :child_id
end
