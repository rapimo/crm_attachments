# Make all core models act as taggable.
#----------------------------------------------------------------------------
require "attached_file"
[ Account, Campaign, Contact, Opportunity,Lead ].each do |klass|
  klass.class_eval { has_many :attached_files, :as => :attachable }
end

