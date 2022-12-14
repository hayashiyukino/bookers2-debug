class SearchsController < ApplicationController
   def search
    # viewのform_tagにて
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @content, @methodを代入した、
    # search_forを@recordsに代入。
    @records = search_for(@model, @content, @method)
   end

  private
  def search_for(model, content, method)
    # 選択したモデルがuserだったら
    if model == 'user'
      # contentの部分が検索ワードと一致するかみる。％の部分は何のワードが入っていてもよい
      
      # 選択した検索方法が完全一致だったら
      if method == 'perfect'
        User.where(name: content)
      # 選択した検索方法が部分一致だったら
      elsif method == 'partial'
        User.where('name LIKE?', '%'+content+'%')
      # 選択した検索方法が前方一致だったら
      elsif method == 'forward'
        User.where('name LIKE?', content+'%')
      # 選択した検索方法がそれら以外(後方一致）だったら
      else 
        User.where('name LIKE?', '%'+content)
      end
    # 選択したモデルがbookだったら
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'partial'
        Book.where('title LIKE ?', '%'+content+'%')
      elsif method == 'forward'
        Book.where('title LIKE?', content+'%')
      else
        Book.where('title LIKE?', '%'+content)
      end
    end
  end
end
