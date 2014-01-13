class DynamicFileLinkController < ApplicationController
  unloadable

  before_filter :require_login
  before_filter :find_project
  before_filter :init_dynamic_file_link

  def get
    if @attachment.container.is_a?(Version) || @attachment.container.is_a?(Project)
      @attachment.increment_download
    end

    if stale?(:etag => @attachment.digest)
      send_file @attachment.diskfile, :filename => filename_for_content_disposition(@attachment.filename),
                                      :type => detect_content_type(@attachment),
                                      :disposition => (@attachment.image? ? 'inline' : 'attachment')
    end
  end

private
  def detect_content_type(attachment)
    content_type = attachment.content_type
    if content_type.blank?
      content_type = Redmine::MimeType.of(attachment.filename)
    end
    content_type.to_s
  end

  def init_dynamic_file_link
    @attachment = Attachment.find(
      :first,
      :conditions => ['container_type = ? and container_id = ? and filename = ?', 'Project', @project.id, params[:filename]],
      :order => 'id desc'
      )

    raise ActiveRecord::RecordNotFound if @attachment.nil?
    raise ActiveRecord::RecordNotFound if params[:filename] && params[:filename] != @attachment.filename

  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_project
    begin
      @project = Project.find(name = params[:id])

    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
