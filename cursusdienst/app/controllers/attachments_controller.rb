class AttachmentsController < ApplicationController
  before_filter :allowed
  
  def download
    deny_access and return unless signed_in?
    file = Attachment.find(params[:attachment_id])
    send_file "public/#{file.item_url}"
  end
  
  private
  
  def allowed
    deny_access unless signed_in?
    deny_privileged_access and return unless current_user.can?('download_materials')
  end
end
