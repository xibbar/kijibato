class Group < ActiveRecord::Base
  validates_format_of :initial, with: /[a-zA-Z_-]/
  validates_presence_of :initial, :name, :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :initial
  validates_length_of :initial, maximum: 32, minimum: 4

  has_many :users, dependent: :destroy
  has_many :articles, dependent: :destroy
end
