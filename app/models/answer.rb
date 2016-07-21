class Answer < ApplicationRecord
  belongs_to :question, optional: true
  belongs_to :user

  validates :body, :user_id, presence: true

  def check(question, type)
    Question.find(question).answers.where(correct: type).map{ |a| a.body.eql?(self.body)}.include?(true)
  end
end
