require 'spec_helper'

describe QueriesController do
  render_views
  
  describe "GET 'index'" do
    
    it "should be successful" do
      get :index
      response.should be_success
    end
    
    it "should have the right title" do
      get :index
      response.should have_selector("title", :content => "All Queries")
    end
    
    pending "should have an element for each query" do
      get :index
      @queries[0..2].each do |query|
        response.should have_selector("li", :content => query.name)
      end
    end
    
    pending "should paginate queries" do
      get :index
      response.should have_selector("div.pagination")
      response.should have_selector("span.disabled", :content => "Previous")
      response.should have_selector("a", :href => "/queries?page=2",
                                         :content => "2")
      response.should have_selector("a", :href => "/queries?page=2",
                                         :content => "Next")
    end
    
  end

  describe "GET 'new'" do
    pending "should be successful" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do
    pending "should be successful" do
      post :create, :query => {} #fixme
      response.should be_success
    end
  end

  describe "GET 'show'" do
    pending "should be successful" do
      get :show, :id => 1 #fixme
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    pending "should be successful" do
      get :edit, :id => 1 #fixme
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    pending "should be successful" do
      put :update, :id => 1, :query => {} #fixme
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    pending "should be successful" do
      delete :destroy, :id => 1 #fixme
      response.should be_success
    end
  end

end
