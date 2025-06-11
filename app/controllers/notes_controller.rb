class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_content
  before_action :set_note, only: [:edit, :update, :destroy]

  def index
    @notes = @content.notes
  end

  def new
    @content = Content.find(params[:content_id])
    @note = Note.new
  end

  def create
    @content = Content.find(params[:content_id])
    @note = Note.new(note_params)
    @note.user = current_user
    @note.content = @content

    if @note.save
      redirect_to content_notes_path(@content), notice: "Note créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to content_notes_path(@content), notice: "Note mise à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    redirect_to content_notes_path(@content), notice: "Note supprimée avec succès."
  end

  private

  def set_content
    @content = Content.find(params[:content_id])
  end

  def set_note
    @note = @content.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:description, :video_timestamp)
  end
end
