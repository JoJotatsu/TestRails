class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_logined

  rescue_from ActiveRecord::RecordNotFound, with: :id_invalid

  private
  def check_logined
    if session[:usr] then
      begin
        @usr = User.find(session[:usr])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end

    unless @usr
      flash[:referer] = request.fullpath
      redirect_to controller: :login, action: :index
    end
  end

  def id_invalid(e)
    render 'shared/record_not_found', status: 404
  end
end
