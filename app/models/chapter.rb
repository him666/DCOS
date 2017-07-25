class Chapter < ApplicationRecord
  belongs_to :document
  validates :unique_id, presence: true
  validates :unique_id, uniqueness: true
  has_many :sections, dependent: :destroy
end
