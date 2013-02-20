require 'spec_helper'

describe CommentsController do
render_views

  before(:all) do
    @user = FactoryGirl.create(:user)
    @ticket = FactoryGirl.create(:ticket)
    @comment = FactoryGirl.create(
      :comment,
      :user_id => @user.id,
      :ticket_id => @ticket.id
    )

    @unathorized_comment  = FactoryGirl.create(
      :comment,
      :user_id => 0,
      :ticket_id => @ticket.id
    )
  end

  before(:each) do
     login_as(@user)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe "POST 'create'" do

    context "success" do

      it "sends back a success status" do
        post_create
        response.status.should eq(200)
      end

      it "sends back true as success" do
        post_create
        Yajl::Parser.parse(response.body)['success'].should be_true
      end

      it "sends back the comment content" do
        post_create
        Yajl::Parser.parse(response.body)['html'].should be_present
      end

    end

    context "failure" do

      before(:each) do
        Comment.any_instance.stub(:save).and_return(false)
      end

      it "sends back a Method Failure status" do
        post_create
        response.status.should eq(424)
      end

      it "sends back false as success" do
        post_create
        Yajl::Parser.parse(response.body)['success'].should be_false
      end

      it "sends back no comment content" do
        post_create
        Yajl::Parser.parse(response.body)['html'].should be_nil
      end

    end

    def post_create
      post :create, :ticket_id => @ticket.id, :comment => FactoryGirl.attributes_for(:comment)
    end

  end

  describe "PUT 'Update'" do

    it "sends back a un authorized status is comment does not belong to user" do
      patch :update, :ticket_id => @ticket.id, :id => @unathorized_comment.id, :comment => {:content => "text"}
        response.status.should eq(403)
    end

    context "success" do

      before(:each) do
        get_edit
      end

      it "sends back a success status" do
        response.status.should eq(200)
      end

      it "sends back true as success" do
        Yajl::Parser.parse(response.body)['success'].should be_true
      end

      it "sends back the editing form" do
        Yajl::Parser.parse(response.body)['html'].should be_present
      end

    end

    def get_edit
      get :edit, :ticket_id => @ticket.id, :id => @comment.id
    end

  end

  describe "PUT 'Update'" do

    it "sends back a un authorized status is comment does not belong to user" do
      patch :update, :ticket_id => @ticket.id, :id => @unathorized_comment.id, :comment => {:content => "text"}
        response.status.should eq(403)
    end

    context "success" do

      before(:each) do
        put_update
      end

      it "sends back a success status" do
        response.status.should eq(200)
      end

      it "sends back true as success" do
        Yajl::Parser.parse(response.body)['success'].should be_true
      end

      it "sends back the updated comment content" do
        Yajl::Parser.parse(response.body)['html'].should be_present
      end

    end

    context "failure" do

      before(:each) do
        Comment.any_instance.stub(:save).and_return(false)
        put_update
      end

      it "sends back a Method Failure status" do
        response.status.should eq(424)
      end

      it "sends back false as success" do
        Yajl::Parser.parse(response.body)['success'].should be_false
      end

      it "sends back no comment content" do
        Yajl::Parser.parse(response.body)['html'].should be_nil
      end

    end

    def put_update
      patch :update, :ticket_id => @ticket.id, :id => @comment.id, :comment => {:content => "text"}
    end

  end

  describe "DELETE 'destroy'" do

    it "sends back a un authorized status is comment does not belong to user" do
      delete :destroy, :ticket_id => @ticket.id, :id => @unathorized_comment.id
      response.status.should eq(403)
    end

    context "success" do

      before(:each) do
        delete_destroy
      end

      it "sends back a success status" do
        response.status.should eq(204)
      end

      it "sends back true as success" do
        Yajl::Parser.parse(response.body)['success'].should be_true
      end

    end

    context "failure" do

      before(:each) do
        Comment.any_instance.stub(:delete).and_return(false)
        delete_destroy
      end

      it "sends back a Method Failure status" do
        response.status.should eq(424)
      end

      it "sends back false as success" do
        Yajl::Parser.parse(response.body)['success'].should be_false
      end

    end

    def delete_destroy
      delete :destroy, :ticket_id => @ticket.id, :id => @comment.id
    end

  end


end
