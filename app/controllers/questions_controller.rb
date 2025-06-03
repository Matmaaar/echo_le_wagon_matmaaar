class QuestionsController < ApplicationController
  
 def new
  @question = Question.new
  @content = Content.find(params[:content_id]) if params[:content_id].present?
end

  def create
    transcription = params[:transcript]

    if transcription.present?
      questions_and_answers = QuestionGeneratorService.new(transcription).call
      if questions_and_answers
        flash[:questions_and_answers] = questions_and_answers
      else
        flash[:alert] = "Erreur lors de la génération de la question."
      end
    else
      flash[:alert] = "Veuillez fournir une transcription."
    end

    @transcript = transcription
    redirect_to test_path  
  end
end
