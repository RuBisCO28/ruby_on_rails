class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    #@user = User.new(params[:user])    # 実装は終わっていないことに注意!
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # 保存の成功をここで扱う。
      redirect_to @user # = redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  private

    # paramsハッシュでは:user属性を必須とし、
    # 名前、メールアドレス、パスワード、パスワードの確認の属性をそれぞれ許可し、それ以外を許可しない
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
