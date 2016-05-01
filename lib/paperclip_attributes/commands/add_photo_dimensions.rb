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
        add_dimenssions_to_model(dimenssions)
      end

      private

      def extract_dimensions
        PaperclipAttributes::Helpers.with_img_tempfile(model, column) do |tempfile|
          geometry = Paperclip::Geometry.from_file(tempfile)
          { width: geometry.width.to_i, height: geometry.height.to_i }
        end
      end

      def add_dimenssions_to_model(dimenssions)
        return unless dimenssions
        add_dimenssion(dimenssions, :width)
        add_dimenssion(dimenssions, :height)
      end

      def add_dimenssion(dimenssions, dimenssion)
        writter_method = "#{column}_#{dimenssion}="
        model.respond_to?(writter_method)
        model.send(writter_method, dimenssions[dimenssion])
      end
    end
  end
end
