class ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]

  def show
    @user = User.find(params[:id]) # チャット相手を取り出す ※fomdはidしか検索できない(idを複数取得可能)
    rooms = current_user.user_rooms.pluck(:room_id) # ログイン中のユーザーの部屋情報を全て取得
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms) # その中にチャットする相手とのルームがあるか確認
                        # find_byはid以外も色々検索できる(最初にマッチした1件のみ取得可能)

    unless user_rooms.nil? # ユーザールームが無くなかったか？（つまりある）
      @room = user_rooms.room # 変数@roomにユーザー（自分と相手）と紐づいているroomを代入
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id) # 自分の中間テーブルを作る
      UserRoom.create(user_id: @user.id, room_id: @room.id) # 相手の中間テーブルを作る
    end
    @chats = @room.chats # チャットの一覧用の変数
    @chat = Chat.new(room_id: @room.id) # チャットの投稿用の変数
  end

  def create
    @chat = current_user.chats.new(chat_params)
    render :validater unless @chat.save
  end


  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  # フォローしている人限定でDMを送ることができる
  def reject_non_related
      user = User.find(params[:id])
      unless current_user.followed_by?(user) && user.followed_by?(current_user)
        redirect_to books_path # 現在のユーザー（私）がフォローしていて且つ取り出したユーザーが私をフォローしていなかったらbooks_path
      end
  end
end
