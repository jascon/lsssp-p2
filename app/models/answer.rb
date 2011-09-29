class Answer < ActiveRecord::Base
  belongs_to :question
#  validates :content, :presence => true
  #validates :content,:presence=>true

     # Paperclip
  has_attached_file :answer,
    :styles => {
      :thumb=> "50x50#",
      :small  => "100x100>" }
end
