class Content < ApplicationRecord
  belongs_to :subsection
  has_many :interactions, dependent: :destroy
  validates :unique_id, uniqueness: true
  validates :code, :unique_id, presence: true
end
