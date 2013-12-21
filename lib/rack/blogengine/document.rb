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
          case operator[0].strip
          when "show_nav"
            links = []

            documents.each do |document|
              puts document.path
              puts document.title
              link = "<li><a class='btn-primary' href='#{document.path}'>#{document.title}</a></li>"
              links << link
            end

            nav = "<ul>"+links.join()+"</ul>"
            
            @html["{% show_nav %}"] = nav
          else
            #puts "Operator not known"
          end
        end
      end
    end
  end
end