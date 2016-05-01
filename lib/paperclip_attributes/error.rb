module PaperclipAttributes
  module Error
    class InvalidActiveRecordModel < Exception
      def initialize
        super("you need to pass an ActiveRecord model instance")
      end
    end
  end
end
