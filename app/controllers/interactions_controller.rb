class InteractionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_interaction, only: [:show, :edit, :update, :destroy]

  # GET /interactions
  # GET /interactions.json
  def index
    @interactions = Interaction.where(by_who: current_user.id) if params[:ct].nil?
    @interactions = Content.find(params[:ct]).interactions unless  params[:ct].nil?
  end

  # GET /interactions/1
  # GET /interactions/1.json
  def show
  end

  def user

  end

  def content
    @interactions = Interaction.all
  end

  def new
    puts params
    @interaction = Interaction.new
  end

  # GET /interactions/1/edit
  def edit
  end

  # POST /interactions
  # POST /interactions.json
  def create
    content = Content.find(interaction_params[:content_id])
    @interaction =content.interactions.new(interaction_params)

    respond_to do |format|
      if @interaction.save
        format.html { redirect_to @interaction, notice: 'Tu comentario ha sido añadido!' }
        format.json { render :show, status: :created, location: @interaction }
      else
        format.html { render :new }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interactions/1
  # PATCH/PUT /interactions/1.json
  def update
    content = Content.find(@interaction.content_id)
    @interaction = content.interactions.where(id: @interaction.id).first
    params2 = {}
    params2[:content_id] = content.id
    params2.merge(interaction_params)
    respond_to do |format|
      if @interaction.update(params2)
        format.html { redirect_to @interaction, notice: 'Tu comentario ha sido editado correctamente.' }
        format.json { render :show, status: :ok, location: @interaction }
      else
        format.html { render :edit }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interactions/1
  # DELETE /interactions/1.json
  def destroy
    @interaction.destroy
    respond_to do |format|
      format.html { redirect_to interactions_url, notice: 'Interaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_interaction
    @interaction = Interaction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def interaction_params
    params.require(:interaction).permit(:oftype,:msg,:by_who,:author, :content_id)
  end
end
