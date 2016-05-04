class PaperclipAttributesGenerator < Rails::Generators::Base
  VALID_ATTRIBUTES = %w(dimensions color).freeze

  source_root File.expand_path('../templates', __FILE__)

  argument :model, required: true, banner: "model"
  argument :attachment, required: true, banner: "attachment"
  argument :recipes, required: true, type: :array, banner: "recipe_one recipe_two..."

  def generate_migration
    generate "migration #{migration_name} #{migration_attributes}"
  end

  private

  def migration_attributes
    recipes.inject({}) do |result, attribute|
      fail "Invalid attribute given" unless VALID_ATTRIBUTES.include?(attribute)
      case attribute.to_sym
      when :dimensions then result[:width] = result[:height] = :integer
      when :color then result[:dominant_color] = :string
      end
      result
    end.map { |k, v| "#{attachment}_#{k}:#{v}" }.join(" ")
  end

  def migration_name
    "add_#{attachment}_#{recipes.join('_')}_to_#{table_name}"
  end

  def table_name
    model.underscore.pluralize
  end
end
