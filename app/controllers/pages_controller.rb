class PagesController < ApplicationController
  def home
    @title = 'Welcome!'
  end

  def contact
    @title = 'Contact'
  end

  def help
    @title = 'Help'
  end
  
  def about_data
    @title = 'About the Data'
  end

end
