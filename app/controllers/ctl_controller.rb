require 'kconv'

class CtlController < ApplicationController

  #before_action :start_logger
  #after_action :end_logger
  before_action :auth, only: :index

  def para_array
    render text: 'categoryパラメータ:' + params[:category].inspect
  end

  def upload_process
    file = params[:upfile]
    name = file.original_filename
    perms = ['.jpg', '.jpeg', '.gif', '.png']
    if !perms.include?(File.extname(name).downcase)
      result = 'アップロードできるのは画像ファイルのみです'
    elsif file.size > 1.megabyte
      result = 'ファイルサイズは1MBまでです'
    else
      name = name.kconv(Kconv::SJIS, Kconv::UTF8)
      File.open("public/docs/#{name}", 'wb'){ |f| f.write(file.read) }
      result = "#{name.toutf8}をアップロードしました"
    end
    render text: result
  end

  def updb
    @author = Author.find(params[:id])
  end

  def updb_process
    @author = Author.find(params[:id])
    if @author.update(params.require(:author).permit(:data))
      render text: 'ほぞんに成功しました'
    else
      render text: @author.errors.full_messages[0]
    end
  end

  def show_photo
    id = params[:id] ? params[:id] :1
    @author = Author.find(id)
    send_data @author.photo, type: @author.ctype, disposition: :inline
  end

  def log
    logger.unknown('unknown')
    logger.fatal('fatal')
    logger.error('error')
    logger.warn('warn')
    logger.info('info')
    logger.debug('debug')
    render text: 'ログはコンソール、またはログファイルから確認ください'
  end


  def get_xml
    @books = Book.all
    render xml: @books
  end

  def get_json
    @books = Book.find(1)
    render json: @books
  end

  def cookie
    @email = cookies[:email]
  end

  def cookie_rec
    cookies[:email] = { value: params[:email],
    expires: 3.months.from_now, http_only: true }
    render text: 'クッキー保存しました'
  end

  def session_show
    @email = session[:email]
  end

  def session_rec
    session[:email] = params[:email]
    render text: 'セッション保存しました'
  end

  def index
    sleep 3
    render text: 'indexアクションが実行されました'
  end

  private
  def start_logger
    logger.debug('[Start]' + Time.now.to_s)
  end

  def end_logger
    logger.debug('[Finish]' + Time.now.to_s)
  end

  def auth
    name = 'yyamada'
    passwd = '8cb2237d0679ca88db6464eac60da96345513964'
    authenticate_or_request_with_http_basic('Railsbook') do |n,p|
      n == name && Digest::SHA1.hexdigest(p) == passwd
    end
  end
end
