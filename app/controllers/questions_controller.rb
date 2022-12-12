require 'csv'
class QuestionsController < ApplicationController
  before_action :set_questions, only: [:edit, :update, :destroy, :search]
  before_action :correct_user, only: [:edit, :destroy]

  def index
    @tags = Tag.all.order('id ASC')
    @tag_id = params[:tag]
    @questions = Question.page(params[:page]).per(7).order('id ASC')
    # @questions = Question.all.order('id ASC')
    @questions = @questions.where('title LIKE ? ', "%#{params[:search]}%").
                 or(@questions.where('mean LIKE ? ', "%#{params[:search]}%")) if params[:search].present?
   

    respond_to do |format|
      format.html
      format.csv do |csv|
        @questions = Question.all
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
      flash[:alert] = "Word is saved"
      redirect_to questions_path
    else
      flash[:alert] = "Word is not saved"
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @question.update(question_params)
    redirect_to questions_path
  end

  def destroy
    @question.destroy
    redirect_to questions_path, status: :see_other
  end


  private

  def set_questions
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :mean, :image, q_similars_attributes: [:id, :similar_word, :_destroy], 
                                                            q_tags_attributes: [:id, :tag_id, :destroy]).merge(user_id: session[:user_id])
  end

  def send_posts_csv(questions)
    bom = "\uFEFF"
    csv_data = CSV.generate(bom) do |csv|
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

  def correct_user
    redirect_to(questions_path, status: :see_other) unless @question.user.id == current_user.id
  end


end

