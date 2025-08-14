class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  
  def home
    @content = Content.new
  end

  def test
    @content= Content.first
    @question = Question.new
  end

  def uikit
    # This action can be used to render a UI kit page for testing or demonstration purposes.
    # You can add any logic here if needed, or leave it empty to just render the view.
  end
end
