class Response < ApplicationRecord
  belongs_to :interaction
  validates :unique_id, uniqueness: true
  validates :msg, :author, presence: true
end
