module PaperclipAttributes
  module Attributes
    extend ActiveSupport::Concern
    Cmd = PaperclipAttributes::Commands

    included do
      before_save do
        columns = Cmd::GetChangedPaperclipColumns.new(self).perform
        columns.each do |column|
          Cmd::AddPhotoDimensions.new(self, column).perform
          Cmd::AddPhotoDominantColor.new(self, column).perform
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, PaperclipAttributes::Attributes)
