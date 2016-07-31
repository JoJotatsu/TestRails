class Author < ApplicationRecord
  belongs_to :user

  validate :file_invalid?

  def data=(data)
    self.ctype = data.content_type
    self.photo = data.read
  end

  private
  def file_invalid?
    ps = ['image/jpeg', 'image/gif', 'image/png', 'image/jpg']
    errors.add(:photo, 'は画像ファイルではありません。') if !ps.include?(self.ctype)
    errors.add(:photo, 'のサイズが１MBを超えています。') if self.photo.length > 1.megabyte
  end
end
