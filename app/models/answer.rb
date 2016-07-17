class Answer < ApplicationRecord
  belongs_to :question, optional: true

  def check(question)
    Question.find(question).answers.where(correct: true).map{ |a| a.body.eql?(self.body)}.include?(true)
  end
end
