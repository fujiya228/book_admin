class ProfileController < ApplicationController
  def show
  end

  def edit
  end

  def update
    user = current.user
    # params[:user] => {name: "bob", email: "bob@example.com"}
    # user.update(params[:user]) # これだと変更してはだめなものを変更できる脆弱性
    user.update(user_params)
  end

  private
  # 外部から渡されるパラメータをそのまま信用せず、ホワイトリスト方式で検査
  def user_params
    if current_user.admin?
      params.require(:user).permit(:name, :email, :admin)
    else
      params.require(:user).permit(:name, :email)
  end
end
