class User < ActiveRecord::Base
  has_attached_file :avatar, attributes: [:dimensions, :color]
  do_not_validate_attachment_file_type :avatar

  validates :name, presence: true
end
