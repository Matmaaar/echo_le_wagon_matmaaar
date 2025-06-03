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

    redirect_to @content, notice: "Question générée avec succès."

  def index
    @contents = current_user.contents
    @content = Content.new
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
      @content.get_transcript
      @content.enrich
      redirect_to @content, notice: "Transcription réussie !"
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def content_params
    params.require(:content).permit(:url)
  end

end
