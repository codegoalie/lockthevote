# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: votechain.proto for package 'votechain'

require 'grpc'
require_relative './votechain_pb'

module Votechain
  module PollingStation
    class Service
      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'votechain.PollingStation'

      rpc :Cast, Vote, Result
    end

    Stub = Service.rpc_stub_class
  end
  module ChainNode
    class Service
      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'votechain.ChainNode'

      rpc :GetLatestBlock, Empty, Block
      rpc :GetBlock, BlockNumber, Block
      rpc :Coordinate, stream(Block), stream(Block)
    end

    Stub = Service.rpc_stub_class
  end
end
