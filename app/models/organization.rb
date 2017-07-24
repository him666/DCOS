class Organization < ApplicationRecord
  has_many :documents, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
end
