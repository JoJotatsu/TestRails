class HelloController < ApplicationController

  #before_action :check_logined, only: :view
  skip_before_action :check_logined, only: :list

  def find
    @books = Book.find([2, 5, 10])
    render 'hello/list'
  end

  def find_by
    @books = Book.find_by(publish: '技術評論社')
    render 'hello/list'
  end

  def view
    @msg = 'こんにちは、世界！'
    #render 'hello/special'
  end
end
