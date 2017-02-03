class ElectionsController < ApplicationController
  def index
    @elections = Election.all
  end
end
