module HeraCms
  class Link < ApplicationRecord
    validates :identifier, presence: true, uniqueness: true
    validates :path, presence: true

    before_save :update_seed
  end
end
