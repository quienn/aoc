;;; Day 1: Calorie Counting
;; https://adventofcode.com/2022/day/1

(local {: time} (require :aoc))

(lambda solution [input_data]
  (local inlined (-> input_data
                     (: :gsub "\n" "-")
                     (: :gsub "%-%-" "|")))
  (let [elfs []]
    (var elf-idx 1)
    (each [?elf (inlined:gmatch "([^|]+)")]
      (each [?calorie (: ?elf :gmatch "([^-]+)")]
        (when (not (. elfs elf-idx))
          (tset elfs elf-idx 0))
        (tset elfs elf-idx (+ (. elfs elf-idx) (tonumber ?calorie))))
      (set elf-idx (+ elf-idx 1)))
    (table.sort elfs)
    (values (. elfs (length elfs))
            (+ (. elfs (length elfs))
               (. elfs (- (length elfs) 1))
               (. elfs (- (length elfs) 2))))))

(with-open [input_file (io.open :calorie_counting.txt :r)]
  (print (time solution (input_file:read "*all"))))
