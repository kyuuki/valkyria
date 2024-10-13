class Post < ApplicationRecord
  has_and_belongs_to_many :sites
  has_and_belongs_to_many :tags

  validates :title, presence: true, length: { maximum: 80 }
  validates :content, presence: true, length: { maximum: 10000 }
  validates :posted_at, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "posted_at", "status", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["sites", "tags"]
  end
end
