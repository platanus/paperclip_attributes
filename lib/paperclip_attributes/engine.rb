module PaperclipAttributes
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework false
    end

    initializer "initialize" do
      require_relative "./error"
      require_relative "./commands/get_changed_paperclip_columns"
      require_relative "./commands/add_photo_dimensions"
      require_relative "./attributes"
    end
  end
end
