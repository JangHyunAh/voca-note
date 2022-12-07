class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :restart, :scoring, :continue, :update, :back]
  before_action :set_list, only: [:update, :back]
  # before_action :set_lists, only: [:scoring]
  # before_action :set_list_back, only: [:back, :scoring]
  before_action :set_save_answer, only: [:update, :scoring]
  # before_action :set_list_quiz, only: [:show, :update, :back, :scoring]
 
  def index
    @quizzes = Quiz.page(params[:page]).per(7).order('id ASC')
    # @user = current_user
  end
  
  def show
    @lists = @quiz.lists.order(question_number: 'ASC')
    
    # @list = List.find(params[:id])   
    # @right_question = @list.questions.find(@list.right_answer)
    # @choices = @list.questions.shuffle    
  end

  def create
    rand_ids = Question.ids.sample(10)
    quiz = current_user.quizzes.new(score: 0)
    rand_ids.each.with_index(1) do |question, i|
      choices = [] 
      choices.push(question) #当たる解
      except_ids = Question.ids.reject{ |v| v == question } 
      choices.push(except_ids.sample(2))
      choice_array = choices.flatten
      list = quiz.lists.new(question_number: i)
      choice_array.each_with_index do |choice, j|
        list.right_answer = choice if j == 0
        list.question_lists.new(question_id: choice)
      end
    end
    quiz.save
    redirect_to quiz_list_path(quiz.id, quiz.lists.find_by(question_number: 1))
  end
   
  def restart
    @quiz.update(score: 0, is_propose: false)
    @quiz.lists.update_all(answer_number: 0, is_answer: false, quiz_answer: 0) #全ての情報アップデートする
    redirect_to quiz_list_path(@quiz.id, @quiz.lists.find_by(question_number: 1).id)
  end


  def update
    @next_list = @quiz.lists.where('id > ?', @list.id).order('id ASC').first
    
    if @next_list.nil?
      @quiz.lists.each do |list|
        @quiz.update(score: @quiz.score += 1) if list.right_answer == list.answer_number
        @quiz.update(is_propose: true)
      end
      redirect_to quiz_path(@quiz.id) and return
    end

    @next_right_question = @next_list.questions.find(@next_list.right_answer)
    
    @next_choices = @next_list.questions.shuffle
    
    respond_to do |format|
      format.html {redirect_to quiz_list_path(@quiz.id, @next_list.id)}
      format.js 
        # render 'update.js.erb',
        #        locals: { list: @next_list, quiz: @quiz, right_question: @next_right_question, choices: @next_choices }
      # end
    end
  end


  def continue
    if @quiz.score == 0
      @quiz.lists.each do |list|
        @quiz.update(score: @quiz.score += 1) if list.right_answer == list.answer_number
      end
    end
    @quiz.update(is_propose: true)
    redirect_back fallback_location: scoring_quiz_path(@quiz.id)
  end


  def back
    @back_list = @quiz.lists.where('id <= ?', @list.id).order('id DESC').first

    @back_right_question = @back_list.questions.find(@back_list.right_answer)
    
    @back_choices = @back_list.questions.shuffle
    
    respond_to do |format|
      format.html {redirect_to quiz_list_path(@quiz.id, @back_list.id)}
      format.js 
        # render 'update.js.erb',
        #        locals: { list: @next_list, quiz: @quiz, right_question: @next_right_question, choices: @next_choices }
      # end
    end
  end

  def destroy
    @quiz.destroy
    redirect_to quizzes_path
  end


  # def back
  #   p 
  #   @list = List.find(params[:id])

  #   @list.update(is_answer: false) if @list.is_answer == true


  #   respond_to do |format|
  #     format.html {redirect_to quiz_list_path(@quiz.id)}
  #     format.js 
  #     #   render 'lists/back.js.erb', locals: { list: @list, quiz: @quiz, right_question: @right_question, choices: @choices }
  #     # end
  #   end

  # end
  def scoring 
    @lists = @quiz.lists.order(question_number: 'ASC')
  end

  


  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  # def set_quiz_scoring
  #   @quiz_id = List.find(params[:quiz_id])
  # end

  # def set_lists
  #   @lists = List.find(params[:id])
  # end

  def set_save_answer
    if params[:quiz].nil?
      # @list_s = List.find(params[:id])
      @list.update(quiz_answer: 0, is_answer: true, answer_number: 0)
      
    else
      @list.update(quiz_answer: params[:quiz][:answer_number].split('_')[0], is_answer: true,
                   answer_number: params[:quiz][:answer_number].split('_')[1])
    end
  end


  
  # def set_list_quiz
  #   @list = List.find(params[:id])
  #   @quiz = Quiz.find(params[:quiz_id])
  # end

end
