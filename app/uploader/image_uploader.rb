# encoding: utf-8
require 'securerandom'
require 'carrierwave/processing/mini_magick'
class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  storage :file

  #cap部署的时候，图片需要上传到public下面的system目录
  def store_dir
    "system/uploads/#{model.class.to_s.underscore}"
  end

  def filename
    @name ||= "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end


protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, ::SecureRandom.uuid)
  end

end
