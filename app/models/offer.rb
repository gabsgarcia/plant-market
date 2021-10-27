class Offer < ApplicationRecord
  CATEGORIES = ["medicinal", "florifera", "decoração"]

  belongs_to :user

  validates :id_user, :title, :category, :status, presence: true
  validates :title, length: { minimum: 6 }
  validates :category, inclusion: { in: CATEGORIES }
end
