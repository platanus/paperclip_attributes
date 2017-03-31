module PaperclipAttributes
  module Commands
    class AddPhotoDimensions
      include PaperclipAttributes::Command

      def perform
        dimensions = extract_dimensions
        add_dimensions_to_model(dimensions)
      end

      def adios
        "adios"
      end

      private

      def extract_dimensions
        with_img_tempfile do |tempfile|
          geometry = Paperclip::Geometry.from_file(tempfile)
          { width: geometry.width.to_i, height: geometry.height.to_i }
        end
      end

      def add_dimensions_to_model(dimensions)
        return unless dimensions
        set_attribute(:width, dimensions[:width])
        set_attribute(:height, dimensions[:height])
      end
    end
  end
end
