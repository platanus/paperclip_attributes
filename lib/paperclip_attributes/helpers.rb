module PaperclipAttributes
  module Helpers
    def self.image?(model, column)
      content_type = model.send("#{column}_content_type")
      content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
    end
  end
end
