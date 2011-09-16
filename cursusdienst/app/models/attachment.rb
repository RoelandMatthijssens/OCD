class Attachment < ActiveRecord::Base
  mount_uploader :item, AttachmentUploader
  
  before_save :update_item_attributes

  private

  def update_item_attributes
    if item.present? && item_changed?
      self.content_type = item.file.content_type
      self.file_size = item.file.size
    end
  end
end
