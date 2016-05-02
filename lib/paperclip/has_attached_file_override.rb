module ::Paperclip
  module ClassMethods
    def has_attached_file(name, options = {})
      add_attachment_attributes(name, options)
      HasAttachedFile.define_on(self, name, options)
    end

    def add_attachment_attributes(name, options)
      @attachmets_recipes ||= {}
      @attachmets_recipes[name.to_sym] = options.fetch(:attributes, [])
    end

    def attachmets_recipes
      @attachmets_recipes
    end

    def attachments_names
      attachmets_recipes.keys
    end
  end
end
