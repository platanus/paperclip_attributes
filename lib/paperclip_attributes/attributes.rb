module PaperclipAttributes
  module Attributes
    extend ActiveSupport::Concern

    included do
      before_save do
        # TODO: extract dominant color, dimensions, etc
      end
    end
  end
end

ActiveRecord::Base.send(:include, PaperclipAttributes::Attributes)
