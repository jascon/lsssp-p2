class Attachment < ActiveRecord::Base
  belongs_to :assignment
  has_attached_file :attachment #, :styles => { :large => "640x480", :medium => "300x300>", :thumb => "100x100>" }
=begin
 before_attachment_post_process :prevent_pdf_thumbnail
   def prevent_pdf_thumbnail
     return false if document_file_name.index(".sql")
   end
=end
end
