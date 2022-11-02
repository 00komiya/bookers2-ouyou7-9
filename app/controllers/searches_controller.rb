class SearchesController < ApplicationController
 before_action :authenticate_user!

  def search
    @range = params[:range] # 検索モデル

    # if文で検索モデルの条件分岐をさせる、loolsメソッド使って検索内容を取得、変数に代入
    if @range == "User"
      @users = User.looks(params[:search], params[:word]) #検索方法,検索ワード
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end
end
