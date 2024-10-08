class Post < ApplicationRecord
  has_and_belongs_to_many :sites
  has_and_belongs_to_many :tags

  validates :title, presence: true, length: { maximum: 80 }
  validates :content, presence: true, length: { maximum: 10000 }
  validates :posted_at, presence: true
end
