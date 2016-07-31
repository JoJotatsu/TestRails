class Book < ApplicationRecord

  has_many :reviews
  has_many :users, through: :reviews

  after_destroy :history_book

  private
  def history_book
    logger.info('delete:' + self.inspect)
  end

  scope :gihyo, -> { where(publish: '技術評論社')}
  scope :newer, -> { order(published: :desc)}
  scope :top10, -> { newer.limit(10)}

  validates :isbn,
    presence: true,
    uniqueness: { allow_blank: true },
    length: { is: 17 , allow_blank: true },
    format: { with: /\A[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}\z/ , allow_blank: true}

  validates :title,
   presence: true,
   length: { minimum: 1, maximum: 100 }

  validates :price,
   numericality: { only_integer: true, less_than: 10000 }

  validates :publish,
   inclusion:{ in: ['技術評論社', '翔泳社', '秀和システム', '日経BP社', 'ソシム'] }
end
