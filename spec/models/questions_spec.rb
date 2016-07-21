require "rails_helper"

RSpec.describe Answer, :type => :model do

  let! (:user_author) { create :user }
  let! (:user_payer) { create :user }
  let! (:question) { create :question, user_id: user_author.id }
  let! (:correct_answer) { create :answer, question_id: question.id, user_id: user_author.id, body: "no", correct: true }
  let! (:player_answer) { create :answer, question_id: question.id, user_id: user_payer.id, body: "no" }
  let! (:player_answer2) { create :answer, question_id: question.id, user_id: user_payer.id, body: "yes" }

  describe "#number_of_answers" do
    it "count sum of correct answers(incluce author answer)" do
      expect(question.number_of_answers("no")).to eq(2)
    end
    it "count sum of incorrect answers" do
      expect(question.number_of_answers("yes")).to eq(1)
    end
  end

end
