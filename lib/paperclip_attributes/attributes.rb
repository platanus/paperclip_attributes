module PaperclipAttributes
  module Attributes
    extend ActiveSupport::Concern

    COMMANDS = {
      color: PaperclipAttributes::Commands::AddPhotoDominantColor,
      dimensions: PaperclipAttributes::Commands::AddPhotoDimensions
    }

    included do
      def changed_attachments_names
        self.class.attachments_names.select do |column|
          send("#{column}_updated_at_changed?")
        end
      end

      def get_attachment_recipes(attachment)
        self.class.attachmets_recipes[attachment]
      end

      before_save do
        changed_attachments_names.each do |changed_attachment|
          recipes = get_attachment_recipes(changed_attachment)
          recipes.each { |recipe| COMMANDS[recipe].new(self, changed_attachment).perform }
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, PaperclipAttributes::Attributes)
