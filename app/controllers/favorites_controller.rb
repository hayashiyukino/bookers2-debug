class FavoritesController < ApplicationController

  # createアクション(いいねを押す機能)を定義
  def create
    Favorite.create(user_id: current_user.id, book_id: params[:id])
    redirect_to request.referer
  end

  # destroyアクション(いいねを解除する機能)を定義
  def destroy
    # 「find_byメソッド」は、複数の検索条件を指定することができるメソッド
    Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy
    redirect_to request.referer
  end
  
  def index
    # @booksにBookテーブルに保存されたデータを全取得する
    @books = Book.all
    @user = current_user
    # @bookに空のモデルオブジェクトBookを作成し代入する
    @book = Book.new
  end
  
end
