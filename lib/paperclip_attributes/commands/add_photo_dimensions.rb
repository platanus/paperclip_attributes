module PaperclipAttributes
  module Commands
    class AddPhotoDimensions
      attr_reader :model, :column

      def initialize(model, column)
        @model = model
        @column = column
      end

      def perform
        dimenssions = extract_dimensions
        copy_dimenssions_on_model(dimenssions)
      end

      private

      def extract_dimensions
        return unless PaperclipAttributes::Helpers.image?(model, column)
        tempfile = model.send(column).queued_for_write[:original]
        return if tempfile.nil?
        geometry = Paperclip::Geometry.from_file(tempfile)
        { width: geometry.width.to_i, height: geometry.height.to_i }
      end

      def copy_dimenssions_on_model(dimenssions)
        return unless dimenssions
        copy_dimenssion(dimenssions, :width)
        copy_dimenssion(dimenssions, :height)
      end

      def copy_dimenssion(dimenssions, dimenssion)
        writter_method = "#{column}_#{dimenssion}="
        model.respond_to?(writter_method)
        model.send(writter_method, dimenssions[dimenssion])
      end
    end
  end
end
