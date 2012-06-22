class Album < ActiveRecord::Base
  mount_uploader :cover, CoverUploader

  has_many :musics

  validates :name, presence: true
end
