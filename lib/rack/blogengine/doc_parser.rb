module Rack
  module Blogengine
    class DocParser
      # Parse in .content Documents.
      # @param target.
      # @return [Hash] Documents 
      def self.parseInDocuments(target)
        @target = target
        documents = []

        stylesheet = ::File.open("#{@target}/layout/style.css", "r")
        @css = stylesheet.read
        documents << { path:"/style.css", html: @css }

        layout_file = ::File.open("#{@target}/layout/layout.html", "r")
        @layout = layout_file.read

        Dir.foreach("#{target}/") do |item|
          extension = item.split(".")[1]
          next if item == '.' or item == '..' or extension != "content"
  					
          getFileContents(item)
          @html = fillFileContents(@layout)
  					
          @document = {path: @path, html: @html}
          documents << @document
        end

        return documents
      end

      # Get File Contents (path, title, content)
      # @param file
      def self.getFileContents(file)
        # do work on real items
        content_file = ::File.open("#{@target}/#{file}");
        content = content_file.read

        contentarray = content.split(",")

        contentarray.each do |contentblock|
          if contentblock.include? "[path]:"
            contentblock["[path]:"] = ""
            @path = "/#{contentblock}"
          end

          if contentblock.include? "[title]:"
            contentblock["[title]:"] = ""
            @title = contentblock
          end

          if contentblock.include? "[content]:"
            contentblock["[content]:"] = ""
            @content = contentblock
          end
        end
      end

	    # Replace layout placeholder with content from .content file
	    # @param layout
	    # return [String] html placeholder replaced with content
      def self.fillFileContents(layout)
        html = layout.dup

        html.gsub! "{title}", @title
        html["{content}"] = @content

        return html
      end
    end
  end
end