module Rack
  module Blogengine
    #
    # Prepares the documents for the response
    # Reads in layout.html and .content file -> merged html
    # Sort documents by date
    # Execute Content Operator after all documents has been parsed in
    #
    # @author [benny]
    #
    module DocumentParser
      class << self
        attr_accessor :title, :content, :date, :target
      end

      # Parse in .content Documents.
      # @param target.
      # @return [Hash] Documents
      def self.parse_in_documents(target)
        @target = target
        documents = []

        layout_file = ::File.open("#{@target}/assets/layout/layout.html", 'r')
        @layout = layout_file.read

        Dir.foreach("#{target}/") do |item|
          extension = item.split('.')[1]
          next if item == '.' || item == '..' || extension != 'content'

          get_file_contents(item)
          @html = fill_file_contents(@layout, @title, @content, @date)

          @document = Document.new
          @document.path = @path
          @document.html = @html
          @document.title = @title
          @document.date = @date

          documents << @document
        end

        generate_highlight_css(@target)
        sort(documents)

        # Has to exec operator after all docs were read,
        # so documents are available for operators (list all docs, etc...)
        documents.each do |document|
          document.exec_content_operator(documents, @target)
        end

        documents.map do |document|
          document.to_hash
        end
      end

      # Get File Contents (path, title, content)
      # @param [String] file
      def self.get_file_contents(file)
        content_file = ::File.open("#{@target}/#{file}")
        content = content_file.read

        contentarray = get_content_array(content)

        contentarray.each do |contentblock|
          if contentblock.include? '[path]:'
            contentblock['[path]:'] = ''
            @path = "/#{contentblock}"

          elsif contentblock.include? '[title]:'
            contentblock['[title]:'] = ''
            if contentblock.strip.empty?
              fail "Title in #{file} is empty"
            else
              @title = contentblock.strip
            end

          elsif contentblock.include? '[content]:'
            contentblock['[content]:'] = ''
            if contentblock.strip.empty?
              fail "Content in #{file} is empty"
            else
              @content = contentblock.strip
            end

          elsif contentblock.include? '[date]:'
            contentblock['[date]:'] = ''
            if /\d/.match( contentblock )
              datearray = contentblock.split(',')
              datearray = datearray.map do |date|
                date.to_i
              end

              @date = Date.new(datearray[0], datearray[1], datearray[2])
            else
              fail "Invalid Date in #{file}\n [date]:#{contentblock}[/date]"
            end
          end
        end
      end

      def self.get_content_array(content)
        # Replace Closing tags
        content['/path'] = '/close'
        content['/title'] = '/close'
        content['/content'] = '/close'
        content['/date'] = '/close'

        content.split('[/close]')
      end

      def self.get_highlight_code(content, seperator)
        html = ::Nokogiri::HTML(content)
        klass = html.css(seperator).attr('class')
        brush = klass.to_s.split(':')[1]

        highlight_code = { text: html.css(seperator).text, brush: brush }
      end

      def self.highlight(code, language, target)
        if language
          Pygments.highlight(code, :lexer => language.to_sym)
        else
          code
        end
      end

      def self.generate_highlight_css(target)
        cli = Rack::Blogengine::CommandLineInterface.new
        system("rm #{target}/assets/style/highlight.css") if ::File.exist?("#{target}/assets/style/highlight.css")

        cli.send(:setup, "highlight.css", "#{target}/assets/style", false)

        path = "#{target}/assets/style"

        css = Pygments.css(:style => Rack::Blogengine.config["pygments_style"])
        ::File.open("#{path}/highlight.css", 'w') { |file| file.write(css) }
      end

      # Replace layout placeholder with content from .content file
      # @param [String] layout
      # @param [String] title
      # @param [String] content
      # @param [Date]   date
      # return [String] html placeholder replaced with content
      def self.fill_file_contents(layout, title, content, date)
        html = layout.dup

        html.gsub! '{title}', title
        html['{content}'] = content
        html.gsub! '{date}', date.strftime('%d.%m.%Y')

        html = Nokogiri::HTML(html)
        seperator = Rack::Blogengine.config["pygments_seperator"]

        html.css(seperator).map do |html|
          highlight_code = get_highlight_code(html.to_s, seperator)
          highlighted = highlight(highlight_code[:text], highlight_code[:brush], @target)

          html.replace(highlighted)
        end

        return html.to_s
      end

      # Sort documents array by date of each documenthash
      # @param [Array] documents
      # return [Array] documents (sorted)
      # Should it be sorted in Core or in the operator??
      def self.sort(documents)
        documents.sort! do | a, b |
          a.date.to_time.to_i <=> b.date.to_time.to_i
        end

        documents
      end
    end
  end
end
