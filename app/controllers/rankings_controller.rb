class RankingsController < ApplicationController
  def index

    @users = User.all.order(rate: 'DESC')

    @user = current_user

    # すべてのscoreの合計数
    score_array = []
    @user.quizzes.each do |quiz|
      score_array << quiz.score
    end
    @score_sum = score_array.sum

    # すべてのlistの合計数
    @list_sum = @user.quizzes.size * 10

    # 正答率

    @percentage_correct = @score_sum.fdiv(@list_sum) * 100.round
    @user.update(rate: @percentage_correct)
    # ランキング

    @ranking = 0
        
      @users.each do |user|
        @ranking += 1
        return @ranking if user.id == current_user.id
      end
    

  end

 

end
