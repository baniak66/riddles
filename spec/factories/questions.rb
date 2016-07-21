FactoryGirl.define do
  factory :question do
    body "question text"
    time 30
    comment "question comment"
    publish true
    other_answer true
    user_id nil
  end
end
