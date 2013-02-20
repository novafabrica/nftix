require 'spec_helper'

describe UsersController do

  before(:all) do
    @user = FactoryGirl.create(:user)
  end

  # Setup for shared examples
  let(:outer_params) {{}}
  let(:inner_params) {{}}
  let(:item) { @user }
  let(:singular) { item.class.to_s.underscore.downcase }
  let(:create_redirect_path) {}
  let(:update_redirect_path) { user_path }
  let(:touch_params) {{:first_name => "newname"}}

  after(:all) do
    DatabaseCleaner.clean
  end

  before(:each) { controller.stub!(:logged_in?).and_return true }

  describe "GET 'index'" do
    it_behaves_like "a standard index action"
  end

    describe "GET 'show'" do
    it_behaves_like "a standard show action"
  end

  describe "GET 'new'" do
    it_behaves_like "a standard new action"
  end

  describe "POST 'create'" do
    it_behaves_like "a standard create action"
  end

  describe "GET 'edit'" do
    it_behaves_like "a standard edit action"
  end

  describe "PUT 'update'" do
    it_behaves_like "a standard update action"
  end

  describe "DELETE 'destroy'" do
    it_behaves_like "a standard destroy action"
  end
end