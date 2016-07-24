require "rails_helper"

RSpec.feature "Question actions", :type => :feature do

  given!(:user) { create :user, email: "user@user.com", password: "password" }

  scenario "User creates a new question" do
    visit root_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Log in'

    expect(page).to have_text("You don't have a questions.")
    click_link "Create your first!"

    expect(page).to have_text("New question")
    fill_in "question_body", with: "What?"
    fill_in "question_time", with: "30"
    fill_in "question_answers_attributes_0_body", with: "Answer text"
    choose('other_answer_false')
    fill_in "question_comment", with: "Question comment"
    choose('publish_true')
    click_button "Save"
    expect(page).to have_text("Question was successfully created.")
    expect(page).to have_text("What?")
    expect(page).to have_text("30")

    expect(page).to have_text("Add next question")
  end
end
