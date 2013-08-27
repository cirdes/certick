require 'spec_helper'

describe SessionsController do
  
	describe "POST create" do
	  let(:auth) { double(:auth) }
	  let(:params) { FactoryGirl.attributes_for :user }

	  before do
	    auth.stub(:email=) 
	    auth.stub(:password=) 

	    Eventick::Auth.stub(:new) { auth }
	  end

	  context 'with valid user' do
		  before do
				auth.stub(:token) { "1234567" }
		    post :create, params 
		  end

		  it { should redirect_to(certifieds_path) }
		end

		context 'with invalid user' do
		  before do
				auth.stub(:token) { nil }
		    post :create, params 
		  end

		  it { should redirect_to(root_path) }
		end
	end  

	describe "GET new" do
	  before do
	    get :new
	  end

	  it { response.should render_template("new") }
	end  

end
