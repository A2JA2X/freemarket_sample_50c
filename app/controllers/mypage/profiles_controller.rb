class Mypage::ProfilesController < ApplicationController
  before_action :authenticate_user!
  def edit
  end

  def update
    if current_user.profile.update(profile_params)
      redirect_to action: :edit
    else
      # TODO:更新失敗時の処理を記述
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:body)
  end

end
