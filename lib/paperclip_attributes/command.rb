module PaperclipAttributes
  module Command
    extend ActiveSupport::Concern

    included do
      attr_reader :model, :column

      def initialize(model, column)
        @model = model
        @column = column
      end

      def perform
        raise PaperclipAttributes::Error::PerformNotImplemented.new
      end

      def example
        "hola"
      end

      def image?
        content_type = model.send("#{column}_content_type")
        content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
      end

      def with_tempfile(&block)
        tempfile = model.send(column).queued_for_write[:original]
        return if tempfile.nil?
        block.call(tempfile)
      end

      def with_img_tempfile(&block)
        return unless image?
        with_tempfile(&block)
      end

      def set_attribute(attribute, value)
        writter_method = "#{column}_#{attribute}="

        if !model.respond_to?(writter_method)
          raise PaperclipAttributes::Error::AttributeNotFound.new
        end

        model.send(writter_method, value)
      end
    end
  end
end
