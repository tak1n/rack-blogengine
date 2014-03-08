module Rack
  module Blogengine
    #
    # Document Class
    # Contains attributes path, html, title, date
    #
    # @author [benny]
    #
    class Document
      attr_accessor :path, :html, :title, :date

      # Converts Rack::Blogengine::Docuemnt to Hash
      # @return [Hash] DocumentHashed [Document in Hash Presentation contains :path and :html]
      def to_hash
        hash = {}
        instance_variables.each do |var|
          unless var.to_s == '@title' || var.to_s == '@date'
            hash[var.to_s.delete('@').to_sym] = instance_variable_get(var)
          end
        end
        hash
      end

      # Executes Content Operators and returns modified html
      # @param [Array] documents [Array of Documents available in operators]
      # @param [String] target [Target for executing Operator from Targetfolder]
      #
      # @return [String] @html [Sets @html to modified html from operator]
      def exec_content_operator(documents, target)
        @html.scan(/\{\%(.*?)\%\}/).each do |contentoperator|
          contentoperator = contentoperator[0].strip.to_sym
          operator = Operator.new(target)
          operatorhtml = operator.send(contentoperator, documents, @html)

          @html['{% ' + contentoperator.to_s + ' %}'] = operatorhtml
        end
      end
    end
  end
end
