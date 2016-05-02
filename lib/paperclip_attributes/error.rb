module PaperclipAttributes
  module Error
    class UnknownRecipe < Exception
      def initialize
        super("the given recipe is invalid")
      end
    end
  end
end
