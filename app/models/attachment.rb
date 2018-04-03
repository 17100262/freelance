class Attachment < ApplicationRecord
    belongs_to :job
    has_attached_file :file
    validates_attachment :file,
    content_type: { content_type: ["application/pdf",'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', "image/jpeg", "image/gif", "image/png", "image/jpg", "image/bmp"] }
end