module Enumerable

  def my_group_by
    self.each_with_object(Hash.new{|h,k|h[k]=[]}) do |value,hash| 
      hash[yield(value)] << value
    end
  end

end