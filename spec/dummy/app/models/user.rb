class User < ActiveRecord::Base
  has_attached_file :avatar
  do_not_validate_attachment_file_type :avatar
end
