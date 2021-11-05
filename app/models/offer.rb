class Offer < ApplicationRecord
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_district_and_category,
    against: [ :district, :category],
    using: {
      tsearch: { prefix: true }
    }
  
  CATEGORIES = ["Medicinal", "Florifera", "Decoração", "Suculenta"]

  belongs_to :user

  validates :user_id, :title, :category, :description, presence: true
  validates :title, length: { minimum: 4 }
  validates :category, inclusion: { in: CATEGORIES }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
