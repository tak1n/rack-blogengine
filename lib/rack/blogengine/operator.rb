#
# Operator Class loads in UserOperators on initialize
# Methods defined in this Class are "Default Operators"
#
# @author [benny]
#
class Operator
  def initialize(target)
    Dir.foreach("#{target}/operator/") do |item|
      extension = item.split('.')[1]
      next if item == '.' || item == '..' || extension != 'rb'
      require "#{target}/operator/#{item}"
    end

    extend UserOperator # load user operators
  end

  # define default operators here
end
