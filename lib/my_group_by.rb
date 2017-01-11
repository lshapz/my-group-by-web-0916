# your code goes here
# you will be adding the method #my_group_by to the Enumerable module (mixin)
require 'byebug'
module Enumerable

  def my_group_by(&block)
    foo = self.each_with_object(Hash.new(0)) do |thing, hash|
      group = block.call(thing)
      if hash.keys.include?(group)
        hash[group] << thing
      else 
        hash[group] = [thing]
      end
      # byebug
    end
    # byebug
  end

end

# [1, 2, 3].my_group_by {|num| num.even?}