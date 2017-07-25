class Subsection < ApplicationRecord
  belongs_to :section
  has_many :contents, dependent: :destroy
  validates :unique_id, :order, uniqueness: true
  validates :unique_id, :order, presence: true
end
