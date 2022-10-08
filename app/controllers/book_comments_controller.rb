class BookCommentsController < ApplicationController

  def create
   # (params[:book_id])　で、本の投稿から”ある投稿”を取り出せます。
   # findメソッドを利用して、データベース　から取り出して、bookというローカル変数に入れてあります。
   @book = Book.find(params[:book_id])
  # コメントを新規投稿するための空のインスタンスを作っています
   @comment = current_user.book_comments.new(book_comment_params)
  # 空のインスタンスのbook_idは、今取り出してる"ある投稿”のidだよという意味だと思います。”ある投稿”に対してコメントしますよ〜という感じ
   @comment.book_id = @book.id
   @comment.save
  # create.js.erbで@books @book_commentをわたしているので、book_commentsコントローラーでこの値を定義しないといけない
   @books=Book.find(params[:book_id])
   @book_comment = BookComment.new
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    @comment = BookComment.find(params[:id])
    @comment.destroy
    # create.js.erbで@books @book_commentをわたしているので、book_commentsコントローラーでこの値を定義しないといけない
    # @books=Book.find(params[:book_id])
    # @book_comment = BookComment.newとしてるのは、投稿が残らないようにするため
    @book_comment = BookComment.new

  end
  
  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
  # def correct_user
  #   @comment = current_user.comments.find_by(id: params[:id])
  #   redirect_to root_url if @comment.nil?
  # end
end
