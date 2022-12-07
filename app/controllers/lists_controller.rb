class ListsController < ApplicationController
  before_action :set_list_quiz, only: [:show, :update, :back, :scoring]
  # before_action :set_save_answer, only: [:update, :scoring]
  #right_answer:当たるanswer, answer_number:choicesインデックス, quiz_answer 

  def show
    @right_question = @list.questions.find(@list.right_answer)
    @choices = @list.questions.shuffle   
  end

  # def update
  #   @next_list = @quiz.lists.where('id > ?', @list.id).order('id ASC').first

  #   if @next_list.nil?
  #     @quiz.lists.each do |list|
  #       @quiz.update(score: @quiz.score += 1) if list.right_answer == list.answer_number
  #       @quiz.update(is_propose: true)
  #     end
  #     redirect_to quiz_path(@quiz.id) and return
  #   end

  #   @next_right_question = @next_list.questions.find(@next_list.right_answer)
    
  #   @next_choices = @next_list.questions.shuffle
    
  #   respond_to do |format|
  #     format.html
  #     format.js do
  #       render 'lists/update.js.erb',
  #              locals: { list: @next_list, quiz: @quiz, right_question: @next_right_question, choices: @next_choices }
  #     end
  #   end
  # end

  # def back
  #   @right_question = @list.questions.find(@list.right_answer)

  #   @choices = @list.questions.shuffle

  #   @list.update(is_answer: false) if @list.is_answer == true


  #   respond_to do |format|
  #     format.html 
  #     format.js do
  #       render 'lists/back.js.erb', locals: { list: @list, quiz: @quiz, right_question: @right_question, choices: @choices }
  #     end
  #   end

  # end


private

  def set_list_quiz
    @list = List.find(params[:id])
    @quiz = Quiz.find(params[:quiz_id])
  end

  # def set_save_answer
  #   if params[:list].nil?
  #     @list.update(quiz_answer: 0, is_answer: true, answer_number: 0)
  #   else
  #     @list.update(quiz_answer: params[:list][:answer_number].split('_')[0], is_answer: true,
  #                  answer_number: params[:list][:answer_number].split('_')[1])
  #   end
  # end

end
