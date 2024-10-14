class Post < ApplicationRecord
  has_and_belongs_to_many :sites
  has_and_belongs_to_many :tags
  has_many :postmetum

  validates :title, presence: true, length: { maximum: 80 }
  validates :content, presence: true, length: { maximum: 10000 }
  validates :posted_at, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "posted_at", "status", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["sites", "tags"]
  end

  # サムネイル取得
  # TODO: 効率化
  def postmeta_thumbnail
    postmetum.find_by(meta_key: "thubmnail")
  end

  def thumbnail
    postmetum.find_by(meta_key: "thubmnail")&.meta_value
  end
end
