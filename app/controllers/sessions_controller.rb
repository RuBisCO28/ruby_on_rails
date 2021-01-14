class SessionsController < ApplicationController
  def new
    #debugger
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in @user
      # ログインユーザー情報を記憶したり忘れたりできる
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      #redirect_to @user
      redirect_back_or @user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
