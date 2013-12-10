# Rack::Blogengine

Rack Middleware to serve a simple blog

## Installation

Add this line to your application's Gemfile:

    gem 'rack-blogengine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-blogengine

## Usage

Create a targetfolder where your Styling & Content is placed.

### Structure

`targetfolder/layout` - save your layout.html and style.css in this folder
`targetfolder/images` - your images will be served from this folder (http://urltoapp/images)
`targetfolder/test.content` - your available blog entries matches to the .content files, each .content file is a blog entry

### Layout

In the layout.html you use {title} and {content} which will then be populated with the values from each .content file
Example:
```html
<!DOCTYPE html>
<html>
	<head>
		<title>{title}</title>
	</head>
	<body>
		<h1>{title}</h1>
		<div>
			{content}
		</div>
	</body>
</html>
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
