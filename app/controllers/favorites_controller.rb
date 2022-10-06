class FavoritesController < ApplicationController
  #「before_action」を使用して、投稿のidを取得できるようにする
  before_action :book_params

  # createアクション(いいねを押す機能)を定義
  def create
    Favorite.create(user_id: current_user.id, book_id: params[:id])
  end

  # destroyアクション(いいねを解除する機能)を定義
  def destroy
    Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy
  end
  
  # 非同期処理で必要
  # 取得した投稿idを保存する
  private

  def book_params
    @book = Book.find(params[:id])
  end
  
end
