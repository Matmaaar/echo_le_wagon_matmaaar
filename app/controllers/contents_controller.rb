class ContentsController < ApplicationController
  def generate_question
    @content = Content.find(params[:id])
    data = @content.generate_question

    if data.nil?
      render json: { error: "Aucune question générée" }, status: :unprocessable_entity
      return
    end

    correct = data[:correct_answer].to_sym
    question = @content.questions.create!(
      statement: data[:question],
      answer_true: data[:choices][correct],
      answer_1: data[:choices].except(correct).values[0],
      answer_2: data[:choices].except(correct).values[1],
      answer_3: data[:choices].except(correct).values[2],
      explanation: data[:explanation]
    )
    
  render turbo_stream: turbo_stream.update("quiz-container", partial: "contents/question", locals: { question: question })
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

  def edit
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    @content.update(content_params)
    redirect_to content_path(@content), notice: "Le titre a bien été mis à jour."
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    @content.user = current_user

    if @content.save
      begin
        @content.enrich!
        ContentJob.perform_later(@content)
        # @content.get_transcript!
        # @content.enrich!
        # @content.summarize!
        # @content.generate_ai_tags_later

        Rails.logger.info("Contenu créé avec enrichissement et résumé.")
        redirect_to @content, notice: "Contenu enrichi avec résumé !"
      rescue => e
        Rails.logger.error("Erreur enrichissement ou résumé : #{e.message}")
        redirect_to @content, alert: "Créé, mais une erreur est survenue lors de l’enrichissement ou la génération de résumé."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def content_params
    params.require(:content).permit(:url, :name)
  end
end
