module PaperclipAttributes
  module Commands
    class GetChangedPaperclipColumns
      PAPERCLIP_SUFFIXES = %w(_content_type _file_name _file_size _updated_at)

      attr_reader :model

      def initialize(model)
        if !model.is_a?(ActiveRecord::Base)
          raise PaperclipAttributes::Error::InvalidActiveRecordModel.new
        end

        @model = model
      end

      def perform
        columns = extract_paperclip_columns(get_column_matches)
        pick_changed_columns(columns)
      end

      private

      def get_column_matches
        model_columns = model.class.column_names
        paperclip_columns = {}

        PAPERCLIP_SUFFIXES.each do |suffix|
          model_columns.each do |column|
            if column.end_with?(suffix)
              candidate_column = column.chomp(suffix)
              paperclip_columns[candidate_column] ||= 0
              paperclip_columns[candidate_column] += 1
            end
          end
        end

        paperclip_columns
      end

      def extract_paperclip_columns(column_matches)
        column_matches.to_a
                      .select { |column| column.last == 4 }
                      .map(&:first)
                      .select { |column| model.send(column).is_a?(Paperclip::Attachment) }
                      .map(&:to_sym)
      end

      def pick_changed_columns(paperclip_columns)
        paperclip_columns.select do |column|
          model.send("#{column}_updated_at_changed?")
        end
      end
    end
  end
end
