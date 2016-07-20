class Question < ApplicationRecord

  belongs_to :user
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true

  def number_of_answers(answer)
    self.answers.where(body: answer).count
  end

end
