require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_attachments, initializer) do
          name "Fat Free CRM Attachments"
       authors "Manuel Kniep"
       version "0.1"
   description "Adds attachment support to Fat Free CRM"
   dependencies :"acts-as-taggable-on", :haml, :simple_column_search, :will_paginate
end

require "crm_attachments"

