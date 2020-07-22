# frozen_string_literal: true

module Decidim
  module Budgets
    # This cell renders the Budgets component header
    class BudgetsHeaderCell < BaseCell
      delegate :highlighted, :voted, to: :current_workflow

      def title
        translated_attribute(current_settings.title).presence || translated_attribute(settings.title)
      end

      def description
        translated_attribute(current_settings.description).presence || translated_attribute(settings.description)
      end

      def voted?
        current_user && current_workflow.voted.any?
      end

      def finished?
        return unless current_workflow.budgets.any?

        current_user && (current_workflow.allowed - current_workflow.voted).none?
      end

      def highlighted_heading
        translated_attribute(current_settings.highlighted_heading).presence || translated_attribute(settings.highlighted_heading)
      end

      def order_path_for(budget)
        budget_order_path(budget)
      end

      private

      def budgets_link_list(budgets)
        budgets.map { |budget| link_to(translated_attribute(budget.title), resource_locator(budget).path) }
               .to_sentence
               .html_safe
      end

      def i18n_scope
        "decidim.budgets.budgets_header"
      end
    end
  end
end