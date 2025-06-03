class QuestionsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:new, :create]
  
    def new
    end

  def create
    transcription = params[:transcription]
    questions = QuestionGeneratorService.new(transcription).call

    flash[:questions] = questions
    redirect_to new_question_path
  end
end


