module HeraCms
  class Text < ApplicationRecord
    validates :identifier, presence: true, uniqueness: true

  end
end
