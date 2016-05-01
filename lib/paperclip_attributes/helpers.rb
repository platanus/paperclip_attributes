module PaperclipAttributes
  module Helpers
    def self.image?(model, column)
      content_type = model.send("#{column}_content_type")
      content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
    end

    def self.with_tempfile(model, column, &block)
      tempfile = model.send(column).queued_for_write[:original]
      return if tempfile.nil?
      block.call(tempfile)
    end

    def self.with_img_tempfile(model, column, &block)
      return unless image?(model, column)
      with_tempfile(model, column, &block)
    end
  end
end
