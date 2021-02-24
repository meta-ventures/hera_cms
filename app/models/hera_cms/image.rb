module HeraCms
  class Image < ApplicationRecord
    validates :identifier, presence: true, uniqueness: true
    if HeraCms.active_storage?
      has_one_attached :upload
    else
      validates :url, presence: true
    end
  end
end
