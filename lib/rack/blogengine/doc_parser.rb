module Rack
	module Blogengine
		class DocParser
			# TODO Write Docparser
			# return 
			# [{
			#  	path: "foo",
			#   html:  HTML
			# }]
			#
			# HTML contains Content, Style, JS etc...
			def self.parseInDocuments(target)
				@target = target
				documents = []


				stylesheet = ::File.open("#{@target}/layout/style.css", "r")
				@css = stylesheet.read
				documents << { path:"/style.css", html: @css }

				layout_file = ::File.open("#{@target}/layout/layout.html", "r")
				@html = layout_file.read

				Dir.foreach("#{target}/") do |item|
					extension = item.split(".")[1]
  					next if item == '.' or item == '..' or extension != "content"
  					
  					getFileContents(item)
  					fillFileContents(@html)
  					
  					@document = {path: @path, html: @html}
  					documents << @document
				end

				return documents
			end

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

			def self.fillFileContents(layout)
				layout.gsub! "{title}", @title
				layout["{content}"] = @content
			end
		end
	end
end