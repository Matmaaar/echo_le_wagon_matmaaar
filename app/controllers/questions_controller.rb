class QuestionsController < ApplicationController


def index
  @questions = Question.all
  @content = Content.find(params[:content_id])
end

def show
  @content = Content.find(params[:content_id])
  @question = Question.find(params[:id])
  @questions = @content.questions
end


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


  def update
    # @content = Content.find(params[:content_id])
    @question = Question.find(params[:id])
    @question.update!(question_params)
    head :ok
  end




  private

 def question_params
    params.require(:question).permit(:validated)
  end
end
