class ContentsController < ApplicationController
  before_action :authenticate_user!
  def generate_questions
   @content = Content.find(params[:id])
  questions_data = @content.generate_questions

  if questions_data.blank? || !questions_data.is_a?(Array)
    render json: { error: "Aucune question générée." }, status: :unprocessable_entity
    return
  end

  @saved_questions = questions_data.map do |data|
    correct = data[:correct_answer]&.to_sym
    next unless correct && data[:choices]&.key?(correct)

    @content.questions.create(
      statement: data[:question],
      answer_true: data[:choices][correct],
      answer_1: data[:choices].except(correct).values[0],
      answer_2: data[:choices].except(correct).values[1],
      answer_3: data[:choices].except(correct).values[2],
      explanation: data[:explanation]
    )
  end.compact


    render :show
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
    if turbo_frame_request?
      render partial: "contents/title"
    else
    redirect_to content_path(@content), notice: "Le titre a bien été mis à jour."
    end
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

  def notes
    Rails.logger.info "=== ACTION NOTES APPELÉE ==="
    @content = Content.find(params[:id])
    @notes = @content.notes
    @note = @content.notes.build
    
    Rails.logger.info "Content ID: #{@content.id}"
    Rails.logger.info "Notes count: #{@notes.count}"
    
    respond_to do |format|
      format.turbo_stream do
        Rails.logger.info "=== TURBO STREAM RESPONSE ==="
      end
      format.html { redirect_to @content } # Fallback
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    redirect_to contents_path, notice: "Content successfully deleted."
  end


  private

  def content_params
    params.require(:content).permit(:url, :name)
  end
end
