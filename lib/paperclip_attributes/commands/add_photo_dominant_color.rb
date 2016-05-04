module PaperclipAttributes
  module Commands
    class AddPhotoDominantColor
      include PaperclipAttributes::Command

      def perform
        color = calculate_dominant_color
        set_attribute(:dominant_color, color)
      end

      private

      def calculate_dominant_color
        with_img_tempfile do |tempfile|
          Miro.options[:color_count] = 1
          Miro.options[:method] = "histogram"
          colors = Miro::DominantColors.new(tempfile.path)
          lighten_color(colors.to_hex.first)
        end
      rescue Exception => e
        default_color = "#BCBABA"
        Rails.logger.info("Error trying to get dominant color...")
        Rails.logger.info(e.message)
        Rails.logger.info("Returning default: #{default_color}")
        default_color
      end

      def lighten_color(hex_color, amount = 0.2)
        hex_color.delete!("#")

        rgb = hex_color.scan(/../).map(&:hex).map do |color|
          [(color.to_i + 255 * amount).round, 255].min
        end

        "#%02x%02x%02x" % rgb
      end
    end
  end
end
