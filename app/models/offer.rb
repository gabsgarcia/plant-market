class Offer < ApplicationRecord
  CATEGORIES = ["medicinal", "florifera", "decoração"]

  belongs_to :user

  validates :user_id, :title, :category, :description, presence: true
  validates :title, length: { minimum: 6 }
  validates :category, inclusion: { in: CATEGORIES }
end
