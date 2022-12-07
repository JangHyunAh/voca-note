class QuestionsController < ApplicationController
  require 'csv'

  def index
    @tags = Tag.all.order('id ASC')
    @tag_id = params[:tag]
    @questions = Question.all
    @questions = @questions.where('title LIKE ?', "%#{params[:question]}%") if params[:question].present?
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_posts_csv(@questions)
      end
    end
  end

  def new
    @question = Question.new
    @question.q_similars.build
    @question.q_tags.build
  end

  def create
    @question = Question.new(question_params)
    @question.image.attach(params[:question][:image])
    
    if @question.save
      redirect_to questions_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
    redirect_to questions_path
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  def search
    @tags = Tag.all
  end



  private

  def question_params
    params.require(:question).permit(:title, :mean, :image, q_similars_attributes: [:id, :similar_word, :_destroy], 
                                                            q_tags_attributes: [:id, :tag_id, :destroy]).merge(user_id: session[:user_id])
  end

  def send_posts_csv(questions)
    csv_data = CSV.generate do |csv|
      column_names = %w[Word Mean]
      csv << column_names
      questions.each do |question|
        column_values = [
          question.title,
          question.mean
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "投稿一覧.csv")
  end

end

