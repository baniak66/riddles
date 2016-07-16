class QuestionsController < ApplicationController

  def index
    @user = current_user
    @questions = @user.questions.all
  end

  def new
    @question = Question.new
  end
end
