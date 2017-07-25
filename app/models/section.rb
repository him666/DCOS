class Section < ApplicationRecord
  belongs_to :chapter
  has_many :subsections, dependent: :destroy
  validates :unique_id, uniqueness: true
  validates :unique_id, :order, presence: true
end
