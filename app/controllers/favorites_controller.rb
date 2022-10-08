class FavoritesController < ApplicationController

  def create
    # まず@favorite には投稿に"いいね"をしたユーザーのuser_id と、"いいね"された投稿のbook_id の情報が入っています。
    # このコードはbuildメソッドを使って、インスタンスを作成しています。
    @favorite = current_user.favorites.build(favorite_params)
    # @book には@favorite に紐づく投稿の情報、つまり"いいね"された投稿の情報が入ります。
    # @book はどの投稿に"いいね"を押したのかを判断するために、ビューを作成するところで使います。
    @book = @favorite.book
    @favorite.save
    
  end

  def destroy
    # find_by = 与えられた条件にマッチするレコードのうち最初のレコードだけを返す。
    # (params[:book_id])で、本の投稿から”ある投稿”を取り出せます。
    @book = Book.find_by(id: params[:book_id])
    # current_user.favorites = ログインしているユーザーのfavoriteテーブルの、
    # find_by(book_id: @book.id) = book_idカラムの中の@book.idと一致するのを探す
    @favorite = current_user.favorites.find_by(book_id: @book.id)
    @favorite.destroy
  end

  private
    def favorite_params
      params.permit(:book_id)
    end

end
