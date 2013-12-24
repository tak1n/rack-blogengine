module Rack
  module Blogengine
    class Document
      attr_accessor :path, :html, :title

      def to_hash
        hash = {}
        instance_variables.each do
          |var| hash[var.to_s.delete("@").to_sym] = instance_variable_get(var) unless var.to_s == "@title"
        end
        hash
      end

      def exec_content_operator(documents)
        @html.scan(/\{\%(.*?)\%\}/).each do |operator|
          Operator.send(operator[0].strip.to_sym, documents, @html)
        end
      end
    end
  end
end