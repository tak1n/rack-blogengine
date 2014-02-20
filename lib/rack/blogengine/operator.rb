#
# Operator Class loads in UserOperators on initialize
# Methods defined in this Class are "Default Operators"
#
# @author [benny]
#
class Operator
  def initialize(target)
  	target = Pathname.new("#{target}").realpath.to_s
    Dir["#{target}/operator/*.rb"].each {|file| require file }

    extend UserOperator # load user operators
  end

  # define default operators here
end
