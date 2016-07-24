require "rails_helper"

RSpec.feature "Answer question", :type => :feature do

  given!(:user) { create :user, email: "user@user.com", password: "password" }
  given!(:question) { create :question, user_id: user.id, body: "What?", other_answer: false }
  given!(:answer) { create :answer, user_id: user.id, question_id: question.id, body: "Nothing", correct: true }

  given!(:player) { create :user, email: "player@user.com", password: "password" }

  context "Player answers a question" do
    before(:each) do
      visit root_path
      fill_in 'Email', :with => player.email
      fill_in 'Password', :with => player.password
      click_button 'Log in'

      click_link "Feed"

      expect(page).to have_text("user@user.com")
      expect(page).to have_text("30")
      expect(page).to have_text("play")

      click_link "Play"

      expect(page).to have_text("What?")
    end

    context "(other answers not allowed)" do
      scenario "correct" do
        fill_in "answer_body", with: "Nothing"
        click_button "Send answer"

        expect(page).to have_text("Congratulations, your answer is correct!")
      end

      scenario "incorrect" do
        fill_in "answer_body", with: "I don'n know"
        click_button "Send answer"

        expect(page).to have_text("You lose, your answer is incorrect!")
      end
    end

    context "(other answers allowed)" do

      given!(:question) { create :question, user_id: user.id, body: "What?", other_answer: true }
      given!(:answer) { create :answer, user_id: user.id, question_id: question.id, body: "Nothing", correct: true }



      scenario "correct" do
        fill_in "answer_body", with: "Nothing"
        click_button "Send answer"

        expect(page).to have_text("Congratulations, your answer is correct!")
      end

      scenario "incorrect" do
        fill_in "answer_body", with: "I don'n know"
        click_button "Send answer"

        expect(page).to have_text("You have to wait for question author response.")
      end
    end


  end
end
