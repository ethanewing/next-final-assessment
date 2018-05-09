class Picture < ApplicationRecord
  mount_uploader :path, ImageUploader

  def self.location_search(location)
    where("location ILIKE ?", "%#{location}%")
  end
end
