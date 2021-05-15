class Exhibition < ApplicationRecord
  validates :name, uniqueness: true
end
