module Rack
  module Blogengine
    class Document

      attr_accessor :path, :html

      def to_hash
        hash = {}
        instance_variables.each {|var| hash[var.to_s.delete("@").to_sym] = instance_variable_get(var) }
        hash
      end

      def exec_content_operator
      	if @html.scan(/\{\%(.*?)\%\}/) == "show_nav"
      end
    end
  end
end