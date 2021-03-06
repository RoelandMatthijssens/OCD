class Attachment < ActiveRecord::Base
  mount_uploader :item, AttachmentUploader

  validates_presence_of :item

  before_save :update_item_attributes

  scope :active, :conditions => {:deleted=>false}

  def basename
    File.basename(item_url)
  end

  private

  def update_item_attributes
    if item.present? && item_changed?
      self.content_type = item.file.content_type
      self.file_size = item.file.size
    end
  end
end
