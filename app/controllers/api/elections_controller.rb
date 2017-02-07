# frozen_string_literal: true
class Api::ElectionsController < Api::ApplicationController
  def index
    @elections = Election.current
  end
end
