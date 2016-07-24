require 'rails_helper'


RSpec.describe QuestionsController, type: :controller do

  let!(:user) { create :user}
  let! (:question) { create :question, user_id: user.id}

  describe "Loged user" do
    before :each do
      sign_in user
    end

    describe "GET #index" do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    describe "GET #new" do
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "GET #show" do
      it "renders the show template" do
        get :show, { id: question.id }
        expect(response).to render_template(:show)
      end

      it "should have matching fields" do
        get :show, { id: question.id }
        expect(question.body).to eq("question text")
        expect(question.time).to eq(30)
        expect(question.comment).to eq("question comment")
      end
    end

    describe "POST #create" do
      let!(:params) { { question: build(:question).attributes } }
      subject { post :create, params}

      it "should creates question" do
        expect{ subject }.to change(Question,:count).by(1)
      end

      it "should display create confirmation notice" do
        subject
        expect(flash[:notice]).to eq 'Question was successfully created.'
      end
    end

    describe "GET #feed" do
      it "responds successfully with an HTTP 200 status code" do
        get :feed
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the feed template" do
        get :feed
        expect(response).to render_template("feed")
      end
    end

    describe "GET #play" do
      it "renders the play template" do
        get :play, { id: question.id }
        expect(response).to render_template(:play)
      end
    end

    # describe "POST #answer" do
    #   let!(:palyer) { create :user}
    #   let!(:params) { { id: question.id, answer: build(:answer).attributes } }
    #   subject { post :answer, params}

    #   it "should creates answer" do
    #     subject
    #     expect{ subject }.to change(Answer,:count).by(1)
    #   end
    # end

    describe "GET #result" do
      let!(:palyer) { create :user}
      let! (:answer) { create :answer, user_id: palyer.id, question_id: question.id}
      it "renders the result template" do
        get :result, { answer_id: answer.id }
        expect(response).to render_template(:result)
      end
    end

    describe "PATCH #evaluate" do
      let!(:palyer) { create :user}
      let! (:answer) { create :answer, user_id: palyer.id, question_id: question.id, correct: true}
      it "should redirects to question" do
        patch :evaluate, { answer_id: answer.id }
        expect(response).to redirect_to(question)
      end
    end

    describe "GET #rating" do
      it "responds successfully with an HTTP 200 status code" do
        get :rating
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the rating template" do
        get :rating
        expect(response).to render_template("rating")
      end
    end
  end

  describe "Anonymous user" do

    describe "GET #index" do
      it "renders the sign in form" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #feed" do
      it "renders the sign in form" do
        get :feed
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #rating" do
      it "renders the sign in form" do
        get :rating
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
