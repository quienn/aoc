--- Day 1: Calorie Counting
-- https://adventofcode.com/2022/day/1

require "pl"

import gsub from string
import split from stringx
import reduce, map from tablex
  
solve = (data) ->
  inventories = List(split (gsub (gsub data, "\n", "-"), "%-%-", "|"), "|")\map(=> split(@, "-"))
  top_elves = List([reduce "+", (map tonumber, elf_inventory) for elf_inventory in *inventories])\sorted!\reverse!
  top_elves[1], reduce "+", top_elves\slice(1, 3)
  
with io.open "calorie_counting.txt", "r"
  print solve \read "*all"
  \close!
    
