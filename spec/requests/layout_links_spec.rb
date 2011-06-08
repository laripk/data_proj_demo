require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a Home page at '/'" do 
    get '/' 
    response.should have_selector('title', :content => "Welcome!") 
  end 

  it "should have a Contact page at '/contact'" do 
    get '/contact' 
    response.should have_selector('title', :content => "Contact") 
  end 

  it "should have a Help page at '/help'" do 
    get '/help' 
    response.should have_selector('title', :content => "Help") 
  end 

  it "should have an All Queries page at '/queries'" do 
    get '/queries' 
    response.should have_selector('title', :content => "All Queries") 
  end 

  it "should have the right links on the layout" do
    visit root_path
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Welcome!")
    click_link "All Queries"
    response.should have_selector('title', :content => "All Queries") 
  end
  
end
