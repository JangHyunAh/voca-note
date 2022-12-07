class TagsController < ApplicationController
  # before_action :logged_in_user,  only: [:index, :edit, :update]
  before_action :set_tag,         only: [:edit, :update, :destroy]
  # before_action :correct_user,    only: [:edit, :destroy]
  
  def index
    @tags = Tag.all.order('id ASC')
    @tags = @tags.where('name LIKE ?', "%#{params[:tag]}%") if params[:tag].present?
  end

  def new
    @tag = Tag.new
  end

  def show
  end
 

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @tag.update(tag_params)
    redirect_to tags_path
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end


  def tag_params
    params.require(:tag).permit(:name).merge(user_id: session[:user_id])
  end

  # def correct_user
  #   @user = User.find(params[:user_id])
  #   redirect_to(tags_path, status: :see_other) unless @tag.user.id == current_user.id
  # end

end
