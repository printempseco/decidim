# frozen_string_literal: true

module Decidim
  module Elections
    # This class serializes an Answer so it can be exported to CSV, JSON or other
    # formats.
    class AnswerSerializer < Decidim::Exporters::Serializer
      include Decidim::ApplicationHelper
      include Decidim::ResourceHelper
      include Decidim::TranslationsHelper

      # Public: Initializes the serializer with an answer.
      def initialize(answer)
        @answer = answer
      end

      # Public: Exports a hash with the serialized data for this answer.
      def serialize
        {
          id: answer.id,
          answer_title: answer.title,
          answer_votes: answer.votes,
          election_id: election.id,
          election_title: election.title,
          question_id: question.id,
          question_title: question.title
        }
      end

      private

      attr_reader :answer

      def election
        answer.question.election
      end

      def question
        answer.question
      end
    end
  end
end
