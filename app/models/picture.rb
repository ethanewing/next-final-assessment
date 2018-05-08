class Picture < ApplicationRecord
  mount_uploader :path, ImageUploader
end
