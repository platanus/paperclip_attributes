module PaperclipAttributes
  module Attributes
    extend ActiveSupport::Concern

    RECIPES = {
      color: PaperclipAttributes::Commands::AddPhotoDominantColor,
      dimensions: PaperclipAttributes::Commands::AddPhotoDimensions
    }

    included do
      def changed_attachments_names
        self.class.attachments_names.select do |column|
          send("#{column}_updated_at_changed?")
        end
      end

      def execute_attachment_recipes(attachment)
        self.class.attachmets_recipes[attachment].each do |recipe|
          cmd = RECIPES[recipe]
          raise PaperclipAttributes::Error::UnknownRecipe.new unless cmd
          cmd.new(self, attachment).perform
        end
      end

      before_save do
        changed_attachments_names.each do |changed_attachment|
          execute_attachment_recipes(changed_attachment)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, PaperclipAttributes::Attributes)
