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

      def to_hash
        hash = {}
        instance_variables.each do |var|
          unless var.to_s == "@title" || var.to_s == "@date"
            hash[var.to_s.delete("@").to_sym] = instance_variable_get(var)
          end 
        end
        hash
      end

      def exec_content_operator(documents, target)
        @html.scan(/\{\%(.*?)\%\}/).each do |contentoperator|
          contentoperator = contentoperator[0].strip.to_sym
          operator = Operator.new(target)
          operatorhtml = operator.send(contentoperator, documents, @html)

          @html["{% "+contentoperator.to_s+" %}"] = operatorhtml
        end
      end
    end
  end
end