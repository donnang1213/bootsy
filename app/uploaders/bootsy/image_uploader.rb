module Bootsy
  class ImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage Bootsy.storage

    def store_dir
      "#{Bootsy.store_dir}/#{model.class.to_s.underscore}/#{model.id}"
    end

    process resize_to_limit: [1160, 2000] , :if =>:pre_limit

    version :large, :if =>:pre_limit do
      process resize_to_fit: [
        Bootsy.large_image[:width], Bootsy.large_image[:height]
      ]
    end

    version :medium , :if =>:pre_limitdo
      process resize_to_fit: [
        Bootsy.medium_image[:width], Bootsy.medium_image[:height]
      ]
    end

    version :small, :if =>:pre_limit do
      process resize_to_fit: [
        Bootsy.small_image[:width], Bootsy.small_image[:height]
      ]
    end

    version :thumb , :if =>:pre_limit do
      process resize_to_fill: [60, 60]
    end

    def extension_white_list
      %w(jpg jpeg png)
    end

  def pre_limit file
    if file && file.size > 2.megabytes
      raise Exception.new("file upload too large")
    end
    true
  end

  end
end
