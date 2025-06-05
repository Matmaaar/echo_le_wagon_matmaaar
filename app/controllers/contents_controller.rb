class ContentsController < ApplicationController

  def generate_question
    @content = Content.find(params[:id])

    question_data = @content.generate_question

    @content.questions.create!(
      statement: question_data[:question],
      answer_true: question_data[:choices][question_data[:correct_answer].to_sym],
      answer_1: (question_data[:choices].except(question_data[:correct_answer].to_sym).values[0]),
      answer_2: (question_data[:choices].except(question_data[:correct_answer].to_sym).values[1]),
      answer_3: (question_data[:choices].except(question_data[:correct_answer].to_sym).values[2]),
      explanation: question_data[:explanation]
    )

    redirect_to @content, notice: "Question generated successfully."
    end

  def generate_summary
    @content = Content.find(params[:id])
    if @content.transcription.present?
      summary = SummaryGeneratorService.new(@content.transcription).call
      if summary
        @content.update(summary: summary)
        flash[:notice] = "Summary generated successfully."
      else
        flash[:alert] = "Summary generated successfully."
      end
    else
      flash[:alert] = "No transcript available to generate a summary."
    end
    redirect_to content_path(@content)
  end

  def index
    @contents = current_user.contents
    @content = Content.new
    if params[:query].present?
      @contents = Content.search_by_name_and_tags(params[:query])
    else
      @contents
    end
  end

  def show
    @content = Content.find(params[:id])
    @questions = @content.questions.shuffle
  end

  def new
    @content = Content.new
  end

  def create
  @content = Content.new(content_params)
  @content.user = current_user

  if @content.save
    begin
      @content.get_transcript!
      @content.enrich!
      @content.summarize!

      # Génère une question automatiquement si la transcription existe
      if @content.transcription.present?
        question_data = @content.generate_question
        if question_data.present?
          correct = question_data[:correct_answer].to_sym
          incorrect = question_data[:choices].except(correct).values

          @content.questions.create!(
            statement: question_data[:question],
            answer_true: question_data[:choices][correct],
            answer_1: incorrect[0],
            answer_2: incorrect[1],
            answer_3: incorrect[2],
            explanation: question_data[:explanation]
          )
        end
      end

      redirect_to @content, notice: "Contenu enrichi avec résumé et question générée !"
    rescue => e
      Rails.logger.error("Erreur enrichissement ou génération question : #{e.message}")
      redirect_to @content, alert: "Créé, mais une erreur est survenue lors de l’enrichissement ou la génération de question."
    end
  else
    render :new, status: :unprocessable_entity
  end
end

  private

  def content_params
    params.require(:content).permit(:url)
  end

end
