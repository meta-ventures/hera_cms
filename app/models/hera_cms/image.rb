module HeraCms
  class Image < ApplicationRecord
    validates :identifier, presence: true, uniqueness: true

    before_save :update_seed
  end
end
