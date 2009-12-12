class AttachedFile < ActiveRecord::Base
  attr_accessor :attachment
  belongs_to :attachable, :polymorphic => true
  STORE_DIR = "#{RAILS_ROOT}/store"

  validates_presence_of :attachment
  
  before_create { |a|
    unless a.attachment.blank? || !File.exists?(a.attachment)
      filename = a.attachment.original_filename
      filename = filename.split("/").last
      filename = filename.split("\\").last
      filename = filename.gsub(/[^\w.]/, '_')
      a.file_name = filename
      a.file_size = a.attachment.size
      a.mime_type = a.attachment.content_type
    end
  }
  after_create {|a|
    unless a.attachment.blank? || !File.exists?(a.attachment)
      File.umask(0)
      unless File.directory?(STORE_DIR)
        Dir.mkdir(STORE_DIR, 0777) rescue nil        
      end
      unless File.directory?(a.path)
        Dir.mkdir(a.path, 0777) rescue nil
      end

       File.open(a.file_path, "wb", 0666) { |f| f.write( a.attachment.read ) } rescue begin
             File.delete(a.attachment)
             a.attachment = nil
       end
     end
  }

  after_destroy { |a|
    File.delete(a.file_path) rescue begin end
  }

  def path
    File.join("#{STORE_DIR}", self.attachable_type.underscore)
  end

  def store_name
    "#{self.id}_#{self.file_name}"
  end

  def file_path
    File.join(self.path, self.store_name)
  end

  def name
    @attributes['name'].blank? ? file_name : @attributes['name']
  end

  def full_name
    "/#{name}"
  end

end