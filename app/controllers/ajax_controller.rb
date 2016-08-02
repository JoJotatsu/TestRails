class AjaxController < ApplicationController
  def upanel
    @time = Time.now.to_s
  end

  def search
    @books = Book.select(:publish).distinct
  end

  def result
    sleep(1)
    @books = Book.where(publish: params[:publish])
  end
end
