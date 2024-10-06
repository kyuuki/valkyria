class Site < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :host, presence: true, length: { maximum: 80 }
  validates :name, presence: true, length: { maximum: 80 }
end
