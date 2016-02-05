class BriefcasesController < ApplicationController
  def index
    @briefcases = current_user.briefcases
  end

  def new
    @briefcase = current_user.briefcases.build
  end

  def create
    @briefcase = current_user.briefcases.build(briefcase_params)
    if @briefcase.save
      redirect_to @briefcase
    else
      render :new
    end
  end

  def show
    @briefcase = current_user.briefcases.find(params[:id])
    plot_data = @briefcase.plot_data
    gon.stocks_data = plot_data[:stocks]
    gon.briefcase_data = plot_data[:briefcase]
  end

  def edit
    @briefcase = current_user.briefcases.find(params[:id])
  end

  def update
    @briefcase = current_user.briefcases.find(params[:id])
    if @briefcase.update_attributes(briefcase_params)
      redirect_to @briefcase
    else
      render :edit
    end
  end

  def destroy
    @briefcase = current_user.briefcases.find(params[:id])
    @briefcase.destroy
    redirect_to briefcases_path
  end

  private

  def briefcase_params
    params.require(:briefcase).permit(:id, :name, briefcases_stocks_attributes: [:id, :stock_id, :_destroy])
  end
end
