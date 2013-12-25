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

`rack-blogengine generate <folder>` will create your Folder skeleton

### Structure

`targetfolder/layout` - save your layout.html in this folder

`targetfolder/assets` - your assets (images, js, css etc) will be served from this folder (http://pathtoapp.tld/assets)

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
### Content

The Content files (.content) includes your content

`[path][/path]` - this will be your access path to your blog entry

`[title][/title]` - the title for your article

`[content][/content]` - your content

### Hint
For a root document (http://pathtoapp.tld/) path should be empty ([path]:[/path])

### Operators

In version 0.1.2 operator handling is included.
To use this new feature you have to create a operator directory in your rackblog folder.
In this directory create your operators (.rb files) with following skeleton

```ruby
module UserOperator
end
```

Your operators are normal ruby methods defined in this module.
Available params are documents & html

Param documents: 
An Array with document objects.
This Document objects has following attributes: path, title, html

Param html:
The content of the file where the operator was included

#### Example

```ruby
module UserOperator
  def show_nav
  end
end
```

In your layout.html then

```html
<div class="nav">	
	{% show_nav %}
</div>
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
