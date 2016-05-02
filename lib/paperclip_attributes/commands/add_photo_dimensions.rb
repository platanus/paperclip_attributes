module PaperclipAttributes
  module Commands
    class AddPhotoDimensions
      attr_reader :model, :column

      def initialize(model, column)
        @model = model
        @column = column
      end

      def perform
        dimensions = extract_dimensions
        add_dimensions_to_model(dimensions)
      end

      private

      def extract_dimensions
        PaperclipAttributes::Helpers.with_img_tempfile(model, column) do |tempfile|
          geometry = Paperclip::Geometry.from_file(tempfile)
          { width: geometry.width.to_i, height: geometry.height.to_i }
        end
      end

      def add_dimensions_to_model(dimensions)
        return unless dimensions
        add_dimension(dimensions, :width)
        add_dimension(dimensions, :height)
      end

      def add_dimension(dimensions, dimension)
        writter_method = "#{column}_#{dimension}="
        model.respond_to?(writter_method)
        model.send(writter_method, dimensions[dimension])
      end
    end
  end
end
