class Picture < ApplicationRecord
  mount_uploader :path, ImageUploader

  def self.location_search(locations)
    where(location: locations)
  end
end
