class RecordController < ApplicationController
  def page
    page_size = 3
    page_num = params[:id] == nil ? 0 : params[:id].to_i - 1
    @books = Book.order(published: :desc).limit(page_size).offset(page_size * page_num)
    render 'hello/list'
  end

  def scope
    @books = Book.gihyo.top10
    render 'hello/list'
  end

  def update_all
    cnt = Book.where(publish: '技術評論社').update_all(publish: 'Gihyo')
    render text: "#{cnt}件のデータを更新しました"
  end

  def destroy
    Book.destroy(params[:id])
  end

  def transact
    Book.transaction do
        b1 = Book.new({isbn: '978-4-7741-4223-0', title: 'Rubyポケットリファレンス',
          price: 2000, publish: '技術評論社', published: '2011-01-01'})
        b1.save!
        #raise '例外発生：処理はキャンセルされました。'
        b2 = Book.new({isbn: '978-4-7741-4223-2', title: 'Tomcatポケットリファレンス',
          price: 2500, publish: '技術評論社', published: '2011-01-01'})
        b2.save!
      end
      render text: 'トランザクションは成功しました。'
    rescue => e
      render text: e.message
  end

  def hasone
    @user = User.find_by(username: 'yyamada')
  end

  def has_many_through
    @user = User.find_by(username: 'isatou')
  end
end
