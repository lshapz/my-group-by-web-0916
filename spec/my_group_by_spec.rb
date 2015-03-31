describe "#my_group_by" do

  let(:alphabet) { ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"] }
  let(:vowels) { ["a", "e", "i", "o", "u", "y"] }
  let(:butterflies) { [:monarch, :viceroy, :tiger_swallowtail, :goliath_birdwing] }
  let(:numbers) { [1, 2, 3, 4, 5, 6] }
  let(:food) { {"apple"=>6, "banana"=>8, "carrot"=>5, "durian"=>9, "eggplant"=>14} }

  it "takes a block" do
    expect { numbers.my_group_by { |i| i%3 } }.to_not raise_error
  end

  it "doesn't change the original array" do
    result = numbers.my_group_by { |i| i%3 }
    expect(numbers).to eq(numbers)
  end

  it "doesn't use #group_by" do     
    expect_any_instance_of(Array).to_not receive(:group_by)
    numbers.my_group_by { |i| i%3 }
  end

  it "groups the collection by result of the block for numbers" do
    result = numbers.my_group_by { |i| i%3 }
    # expect result to be {1=>[1, 4], 2=>[2, 5], 0=>[3, 6]}
    [1, 2, 0].each { |key| expect(result.keys).to include(key) }
    [3, 6].each { |zero_remaining|  expect(result[0]).to include(zero_remaining) }
    [1, 4].each { |one_remaining| expect(result[1]).to include(one_remaining) }
    [2, 5].each { |two_remaining|  expect(result[2]).to include(two_remaining) }
  end

  it "groups the collection by result of the block for strings" do
    result = alphabet.my_group_by { |letter| vowels.include?(letter) }
    # expect result to be {true=>["a", "e", "i"], false=>["b", "c", "d", "f", "g", "h", "j"]}
    [true, false].each { |key| expect(result.keys).to include(key) }
    ["a", "e", "i"].each { |vowel|  expect(result[true]).to include(vowel) }
    ["b", "c", "d", "f", "g", "h", "j"].each do |consonant|  
      expect(result[false]).to include(consonant)
    end
  end

  it "groups the collection by result of the block for symbols" do
    result = butterflies.my_group_by { |butterfly| butterfly.length / 2 }
    # expect result to be {3=>[:monarch, :viceroy], 8=>[:tiger_swallowtail, :goliath_birdwing]}
    [3, 8].each { |key| expect(result.keys).to include(key) }
    [:monarch, :viceroy].each { |butterfly  |  expect(result[3]).to include(butterfly) }
    [:tiger_swallowtail, :goliath_birdwing].each { |butterfly  |  expect(result[8]).to include(butterfly) }
  end

  it "can group hashes by their values" do
    result = food.my_group_by {|food, count| count >= 9}
    # expect result to be 
    # {
    #  false=>[["apple", 6], ["banana", 8], ["carrot", 5]], 
    #  true=>[["durian", 9], ["eggplant", 14]]
    # }
    [true, false].each { |key| expect(result.keys).to include(key) }
    [["apple", 6], ["banana", 8], ["carrot", 5]].each {|array| expect(result[false]).to include(array) }
    [["durian", 9], ["eggplant", 14]].each {|array| expect(result[true]).to include(array) }
  end

  it "can group hashes by their keys" do
    result = food.my_group_by {|food, count| food.length }
    # expect result to be 
    # {
    #   5=>[["apple", 6]], 
    #   6=>[["banana", 8], ["carrot", 5], ["durian", 9]], 
    #   8=>[["eggplant", 14]]
    # }
    [5, 6, 8].each { |key| expect(result.keys).to include(key) }
    expect(result[5]).to eq([["apple", 6]])
    expect(result[8]).to eq([["eggplant", 14]])
    [["banana", 8], ["carrot", 5], ["durian", 9]].each {|array| expect(result[6]).to include(array) }
  end
end
