class BuildersController < ApplicationController
  before_action :set_builder, only: [:show, :edit, :update, :destroy]

  # GET /builders
  def index
    @builders = Builder.all
  end

  # GET /builders/1
  def show
  end

  # GET /builders/new
  def new
    @builder = Builder.new
    render :layout => false
  end

  # GET /builders/1/edit
  def edit
    render :layout => false
  end

  # POST /builders
  def create
    @builder = Builder.new(builder_params)

    respond_to do |format|
      if @builder.save
        format.html { redirect_to builders_path, notice: 'Builder was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /builders/1
  def update
    respond_to do |format|
      if @builder.update(builder_params)
        format.html { redirect_to builders_path, notice: 'Builder was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /builders/1
  # DELETE /builders/1.json
  def destroy
    @builder.disable
    respond_to do |format|
      format.html { redirect_to builders_path, notice: 'Builder was successfully disabled.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_builder
      @builder = Builder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def builder_params
      params.require(:builder).permit(:name, :status)
    end
end
