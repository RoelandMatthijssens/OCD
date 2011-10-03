class AttachmentsController < ApplicationController
  before_filter :allowed
  
  def download
    deny_access and return unless signed_in?
    file = Attachment.find(params[:attachment_id])
    send_file "public/#{file.item_url}"
  end
  
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    flash[:notice] = "Successfully destroyed attachment."
    redirect_to @attachment.gallery
  end
  
  private
  
  def allowed
    deny_access unless signed_in?
    deny_privileged_access and return unless current_user.can?('download_materials')
  end
end
