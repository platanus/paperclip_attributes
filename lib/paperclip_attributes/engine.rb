module PaperclipAttributes
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework false
    end

    initializer "initialize" do
      require_relative "./attributes"
    end
  end
end
