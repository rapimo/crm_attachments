class AttachedFilesController < ApplicationController
  before_filter :require_user

  def new
    @view = params[:view] || "pending"
    @attachment=AttachedFile.new
    if params[:related]
      model, id = params[:related].split("_")
      instance_variable_set("@asset", model.classify.constantize.my(@current_user).find(id))
    end
    respond_to do |format|
      format.js    # new.js.rjs
      format.xml  { render :xml => @attachment }
    end
#  rescue ActiveRecord::RecordNotFound # Kicks in if related asset was not found.
#    respond_to_related_not_found(model, :js) if model
  end

  def upload
    @attachment = AttachedFile.new(params[:attached_file])
    @view = params[:view] || "pending"
    @attachment.save
    responds_to_parent { render }
  end

  def download
    @file = AttachedFile.find(params[:id])
    @file.attachable.class.my(@current_user).find(@file.attachable_id)
    if (@file.mime_type =~ /image.*/)
      disposition = "inline"
	else
      disposition = "attachment"
	end
    send_file @file.file_path, :filename => @file.file_name, :type => @file.mime_type, :disposition => disposition
  rescue ActiveRecord::RecordNotFound
    redirect_back_or_default("/")
  end
end
