require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Lari Kirby's Data Project Demo App"
  end

  describe "GET 'home'" do

    it "should be successful" do
      get :home
      response.should be_success
    end

    it "should have the right title" do
      get :home
      response.should have_selector("title", 
                                    :content => @base_title + " | Welcome!")
    end

  end #home

  describe "GET 'contact'" do

    it "should be successful" do
      get :contact
      response.should be_success
    end

    it "should have the right title" do
      get :contact
      response.should have_selector("title", 
                                    :content => @base_title + " | Contact")
    end

  end #contact

  describe "GET 'help'" do

    it "should be successful" do
      get :help
      response.should be_success
    end

    it "should have the right title" do
      get :help
      response.should have_selector("title", 
                                    :content => @base_title + " | Help")
    end

  end #help

  describe "GET 'about_data'" do

    it "should be successful" do
      get :about_data
      response.should be_success
    end

    it "should have the right title" do
      get :about_data
      response.should have_selector("title", 
                                    :content => @base_title + " | About the Data")
    end

  end #help

end
