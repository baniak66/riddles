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

  def answer
    @question = Question.find(params[:id])
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to result_path(@answer.id)
    end
  end

  def result
    @answer = Answer.find(params[:answer_id])
    if @answer.question.other_answer
      if @answer.check(@answer.question_id, true)
        @answer.correct = true
      elsif @answer.check(@answer.question_id, false)
        @answer.correct = false
      end
    else
      @answer.check(@answer.question_id, true) ? @answer.correct = true : @answer.correct = false
    end
  end

  def evaluate
    @answer = Answer.find(params[:answer_id])
    @answer.correct = params[:evaluation]
    @answer.save
    if @answer.save
      redirect_to question_path(@answer.question_id), notice: 'Answer evaluated.'
    end
  end

  private

    def question_params
      params.require(:question).permit(:body, :time, :comment, :publish, :user_id,
        answers_attributes: [:body, :user_id, :_destroy, :correct])
    end

    def answer_params
      params.require(:answer).permit(:body, :user_id)
    end
end
