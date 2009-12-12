class AttachmentViewHooks < FatFreeCRM::Callback::Base

  #----------------------------------------------------------------------------
  [ :account, :campaign, :contact, :opportunity,:lead ].each do |model|

    define_method "show_#{model}_bottom" do |view, context|
        view.controller.send(:render_to_string, :partial => "/attached_files/show_attachments")
    end
  end

end
