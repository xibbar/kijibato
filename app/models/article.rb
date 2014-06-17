class Article < ActiveRecord::Base
  validates_presence_of :user_id, :group_id, :title, :comment, :name
  belongs_to :group
  belongs_to :user
end
