module HeraCms
  class Link < ApplicationRecord
    validates :identifier, presence: true, uniqueness: true
    validates :path, presence: true

  end
end
