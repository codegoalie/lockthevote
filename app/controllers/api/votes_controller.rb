# frozen_string_literal: true
class Api::VotesController < Api::ApplicationController
  def create
    @vote = current_user.votes.create(vote_params)

    if @vote.valid?
      stub = Votechain::PollingStation::Stub.new('hostmachine.docker:4000',
                                                 :this_channel_is_insecure)
      stub.cast(Votechain::Vote.new(voter_proof: current_user.id.to_s,
                                    race_id: @vote.race.id,
                                    selection: @vote.selection))
      render status: :created
    else
      render status: :bad_request,
             json: { code: 400, messages: @vote.errors.full_messages }
    end
  end

  private

  def vote_params
    params.permit(:race_id, :selection)
  end
end
