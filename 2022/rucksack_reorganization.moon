require "pl"

import sub, byte, gmatch from string
import lines, isupper, split from stringx
import slice from List
import reduce, map from tablex

solve = (input_data) ->
  sum_priority = 0
  grouped_priority = 0

  rucksacks = [line for line in lines input_data]
  for rucksack in *rucksacks
    compartments = {
      Set [sub rucksack, i, i for i = 1, #rucksack / 2]
      Set [sub rucksack, i, i for i = #rucksack / 2 + 1, #rucksack]
    }
    shared_items = Set.values reduce("*", compartments)

    sum_priority += reduce "+",
      map((=> byte(@) - 38 if isupper(@) else byte(@) - 96), shared_items)

  i = 1
  while i < #rucksacks
    group = [Set [char for char in gmatch rucksacks[i + part], "."] for part = 0, 2]
    shared_items = Set.values reduce("*", group)

    grouped_priority += reduce "+",
      map((=> byte(@) - 38 if isupper(@) else byte(@) - 96), shared_items)
    i += 3

  sum_priority, grouped_priority

print solve file.read "rucksack_reorganization.txt"
