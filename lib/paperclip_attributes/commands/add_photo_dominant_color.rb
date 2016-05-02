module PaperclipAttributes
  module Commands
    class AddPhotoDominantColor
      attr_reader :model, :column

      def initialize(model, column)
        @model = model
        @column = column
      end

      def perform
        color = calculate_dominant_color
        add_dominant_color_to_model(color)
      end

      private

      def calculate_dominant_color
        PaperclipAttributes::Helpers.with_img_tempfile(model, column) do |tempfile|
          Miro.options[:color_count] = 1
          Miro.options[:method] = "histogram"
          colors = Miro::DominantColors.new(tempfile.path)
          lighten_color(colors.to_hex.first)
        end
      rescue
        nil
      end

      def lighten_color(hex_color, amount = 0.2)
        hex_color.delete!("#")

        rgb = hex_color.scan(/../).map(&:hex).map do |color|
          [(color.to_i + 255 * amount).round, 255].min
        end

        "#%02x%02x%02x" % rgb
      end

      def add_dominant_color_to_model(color)
        PaperclipAttributes::Helpers.set_attribute(model, column, :dominant_color, color)
      end
    end
  end
end
