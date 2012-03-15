module Skin
  module Searchable
    def self.included base
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def searchable *columns
        scope :search, ->(q) do
          words = (q || '')
            .split(/\s+/)
            .delete_if(&:blank?)
            .map {|w| "%#{w}%" }

          if words.any?
            where columns.map {|column| words.map {|word| "#{column} #{search_operator} ?" }}.flatten.join(' OR '),
              *(words * columns.size)
          end
        end
      end

      def search_operator
        case ActiveRecord::Base.connection.adapter_name
          when "SQLite" then "LIKE"
          else "ILIKE"
        end
      end
    end
  end
end
