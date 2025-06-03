class ContentsController < ApplicationController
  def index
    @contents = current_user.contents
    @content = Content.new
  end

  def show
    @content = Content.find(params[:id])
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
