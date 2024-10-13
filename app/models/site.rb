class Site < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :host, presence: true, length: { maximum: 80 }
  validates :name, presence: true, length: { maximum: 80 }

  def self.ransackable_attributes(auth_object = nil)
    ["about", "catch", "created_at", "host", "id", "name", "template", "updated_at"]
  end

  # サイトに登録されたもののタグ一覧
  def tags
    # もっと効率的に書けないか？
    ids = self.posts.pluck(:id)
    Tag.includes(:posts).where(posts: { id: ids })
  end
end
