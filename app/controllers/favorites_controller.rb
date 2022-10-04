class FavoritesController < ApplicationController

  # createアクション(いいねを押す機能)を定義
  def create
    Favorite.create(user_id: current_user.id, book_id: params[:id])
    redirect_to request.referer
  end

  # destroyアクション(いいねを解除する機能)を定義
  def destroy
    Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy
    redirect_to request.referer
  end
end
