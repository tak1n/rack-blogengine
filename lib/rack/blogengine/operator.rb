libdir = "/var/www/rackblog/operator" # todo get operator dir via targetfolder

Dir.foreach("#{libdir}/") do |item|
	extension = item.split(".")[1]
    next if item == '.' or item == '..' or extension != "rb"
    puts item
    require "#{libdir}/#{item}"
end

class Operator
  extend UserOperator # load user operators

  class << self
  	# define default operators here
  end
end