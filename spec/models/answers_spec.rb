require "rails_helper"

RSpec.describe Answer, :type => :model do

  let! (:user_author) { create :user }
  let! (:user_payer) { create :user }
  let! (:question) { create :question, user_id: user_author.id }
  let! (:correct_answer) { create :answer, question_id: question.id, user_id: user_author.id, body: "no", correct: true }
  let! (:player_answer) { create :answer, question_id: question.id, user_id: user_payer.id, body: "no" }
  let! (:player_answer2) { create :answer, question_id: question.id, user_id: user_payer.id, body: "yes" }

  describe "#check" do
    it "answer is correct" do
      expect(player_answer.check(player_answer.question.id, true)).to eq(true)
    end
    it "answer is incorrect" do
      expect(player_answer2.check(player_answer2.question.id, true)).to eq(false)
    end
  end

end
