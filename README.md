

# My Group By

![apple photograph](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/cs/apple.jpg)

## Contents

1. Objective
2. About Group By
3. Notes
4. Bonus
5. Resources

## Objective

You will be building out Ruby's `#group_by` method. It shouldn't change the array or hash it's called on. Notice how it works on an array and on a hash? You'll be adding the method `my_group_by` to the Enumerable module, so that it can be called on both arrays and hashes.

## About Group By

Ruby's `group_by` method accepts a block. It returns a hash, the keys are the values that result from calling the block on each object, the values are arrays that include the element on which the block was called:

```ruby
vowels = ["a", "e", "i", "o", "u", "y"]
letters =["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]

letters.my_group_by { |letter| vowels.include?(letter) }
#=> {true => ["a", "e", "i"], false => ["b", "c", "d", "f", "g", "h", "j"]}
```

Take a look at another example:

```
numbers = [1, 2, 3, 4, 5, 6]
numbers.my_group_by { |number| number % 3 }
#=> { 1 => [1, 4], 2 => [2, 5], 0 => [3, 6] }
```

The `group_by` method can also be called on hashes:

```ruby

foods = {"apple"=>1, "banana"=>2, "carrot"=>3, "durian"=>4}
foods.my_group_by {|food, count| count >= 2}
#=> {
#     false => [["apple",  1], ["banana", 2]], 
#     true  => [["carrot", 3], ["durian", 4]]
#   }
```

Notice, when it's called on a hash, it returns the key, value pairs in an array of `[key, value]`.

## Notes

You may not call on Ruby's `#group_by` method to accomplish this task.

## Resources

* [Ruby's Group By Method](http://ruby-doc.org/core-2.2.1/Enumerable.html#method-i-group_by)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/my-group-by' title='My Group By'>My Group By</a> on Learn.co and start learning to code for free.</p>
