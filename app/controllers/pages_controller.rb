class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end
  def test  
    @content= Content.first
    @question = Question.new
  end
end
