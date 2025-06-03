class QuestionsController < ApplicationController
    def new
    redirect_back(fallback_location: new_question_path)
    end


  def create
    transcription = params[:transcription]
    questions = QuestionGeneratorService.new(transcription).call

    flash[:questions] = questions
    redirect_to new_question_path
  end
end


