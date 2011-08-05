class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def about
  end

  def idiot
		@title = "Don't be an idiot"
  end

end
