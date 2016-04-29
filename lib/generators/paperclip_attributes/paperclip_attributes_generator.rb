class PaperclipAttributesGenerator < Rails::Generators::Base
  VALID_ATTRIBUTES = %w(dimensions).freeze

  source_root File.expand_path('../templates', __FILE__)

  argument :model, required: true, banner: "model"
  argument :attachment, required: true, banner: "attachment"
  argument :attributes, required: true, type: :array, banner: "attribute_one attribute_two..."

  def generate_migration
    generate "migration #{migration_name} #{migration_attributes}"
  end

  private

  def migration_attributes
    attributes.inject({}) do |result, attribute|
      fail "Invalid attribute given" unless VALID_ATTRIBUTES.include?(attribute)
      case attribute.to_sym
      when :dimensions then result[:width] = result[:height] = :integer
        # TODO: add more cases
      end
      result
    end.map { |k, v| "#{attachment}_#{k}:#{v}" }.join(" ")
  end

  def migration_name
    "add_#{attachment}_#{attributes.join('_')}_to_#{table_name}"
  end

  def table_name
    model.underscore.pluralize
  end
end
