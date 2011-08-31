class Attachment < ActiveRecord::Base
  mount_uploader :item, AttachmentUploader
end
