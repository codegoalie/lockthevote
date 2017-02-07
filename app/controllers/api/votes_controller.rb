# frozen_string_literal: true
class Api::VotesController < Api::ApplicationController
  def create
    @vote = current_user.votes.create(vote_params)

    unless @vote.valid?
      render status: :bad_request,
             json: { code: 400, messages: @vote.errors.full_messages }
    end
  end

  private

  def vote_params
    params.permit(:race_id, :selection)
  end
end
