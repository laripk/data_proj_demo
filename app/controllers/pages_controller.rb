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

end
