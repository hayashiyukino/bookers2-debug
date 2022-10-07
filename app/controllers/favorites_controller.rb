class FavoritesController < ApplicationController
  #「before_action」を使用して、投稿のidを取得できるようにする
  # before_action :book_params
  def createt
    # jsの変数を定義する。ビューで使うものなのでローカル変数ではなくインスタンス変数で記述
    @book = Book.find(params[:book_id])
    # 「いいね」する本の投稿に紐付いているbook_idをparams:で取得
    book = Book.find(params[:book_id])
    favorite = Favorites.new(book_id: book.id)
    favorite.user_id = current_user.id
    favorite.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
  end
  
  # # createアクション(いいねを押す機能)を定義
  # def create
  #   # @favorite には投稿に"いいね"をしたユーザーのuser_id と、"いいね"された投稿のbook_id の情報が入っています
  #   # buildは親モデルに属する子モデルのインスタンスを新たに生成したい場合に使うメソッド
  #   @favorite = current_user.favorites.build(favorite_params)## 親モデル.子モデル.buildという形式
  #   # book には@favorite に紐づく投稿の情報、つまり"いいね"された投稿の情報が入ります。
  #   # @book はどの投稿に"いいね"を押したのかを判断するために、ビューを作成するところで使います。
  #   @book = @favorite.book
  #   # if @favorite.save の部分は、"いいね"が押された時に返すレスポンスのフォーマットをrespond_to メソッドで切り替えています
  #   if @favorite.save
  #     respond_to :js
  #   end
  # end

  # # destroyアクション(いいねを解除する機能)を定義
  # def destroy
  #   @favorite = Favorite.find_by(id: params[:id])
  #   @book = @favorite.book
  #   if @favorite.destroy
  #     respond_to :js
  #   end
  # end

  # private
  #   def favorite_params
  #     params.permit(:book_id)
  #   end
    
    
  # def create
  #   Favorite.create(user_id: current_user.id, book_id: params[:id])
  # end

  # def destroy
  #   Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy
  # end
  
  # # 非同期処理で必要
  # # 取得した投稿idを保存する
  # private

  # def book_params
  #   @book = Book.find(params[:id])
  # end
  
end
