class Answer < ApplicationRecord
  belongs_to :question, optional: true
  belongs_to :user

  def check(question, type)
    Question.find(question).answers.where(correct: type).map{ |a| a.body.eql?(self.body)}.include?(true)
  end
end
