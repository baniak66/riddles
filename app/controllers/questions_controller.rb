class QuestionsController < ApplicationController

  def index
    @user = current_user
    @questions = @user.questions.all
  end

  def new
    @question = Question.new
    @answer = @question.answers.build
  end

  def show
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.publish = params[:publish]
    @question.other_answer = params[:other_answer]
    if @question.save
      redirect_to questions_path, notice: 'Question was successfully created.'
    else
      render 'new'
    end
  end

  def feed
    @questions = Question.all.where.not(user_id: current_user.id, publish: false)
  end

  def play
    @question = Question.find(params[:id])
    @answer = @question.answers.build
  end

  private

    def question_params
      params.require(:question).permit(:body, :time, :comment, :publish, :user_id,
        answers_attributes: [:body, :user_id, :_destroy, :correct])
    end

end
