class ElectionsController < ApplicationController
  def index
    @elections = Election.all
  end

  def show
    @election = Election.includes(:races).find(params[:id])
  end
end
