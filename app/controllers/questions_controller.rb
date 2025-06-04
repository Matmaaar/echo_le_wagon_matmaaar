class QuestionsController < ApplicationController
  
 def new
  @question = Question.new
  @content = Content.find(params[:content_id]) if params[:content_id].present?
end

def create
  @content = Content.find(params[:id]) 

  questions_and_answers = QuestionGeneratorService.new(@content).call

  if questions_and_answers.present?
    flash[:notice] = "Question générée avec succès !"
  else
    flash[:alert] = "Erreur lors de la génération de la question."
  end

  redirect_to content_path(@content)
end
 
end

