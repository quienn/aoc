;;; Day 2: Rock Paper Scissors
;; https://adventofcode.com/2022/day/2

(fn classify [s]
  "Returns the decrypted move and it's corresponing weight."
  (match s
    (where move (or (= move :A) (= move :X))) (values :rock 1)
    (where move (or (= move :B) (= move :Y))) (values :paper 2)
    _ (values :scissors 3)))

(fn win? [turn]
  (match turn
    (where [move op-move]
           (= (classify move) (classify op-move)))
    (values :draw (select 2 (classify move)))

    (where [move op-move]
           (or (and (= (classify move) :rock) (= (classify op-move) :scissors))
               (and (= (classify move) :scissors) (= (classify op-move) :paper))
               (and (= (classify move) :paper) (= (classify op-move) :rock))))
    (values true (select 2 (classify move)))

    _ (values false (select 2 (classify (. _ 1))))))

(fn find-losing [move]
  "Returns the losing move for opponent's `move`."
  (match move
    :A :C
    :B :A
    :C :B))

(fn find-winning [move]
  "Returns the winning move for opponent's `move`."
  (match move
    :A :B
    :B :C
    :C :A))

(fn solve [input_data]
  (var by-prediction-score 0)
  (var by-indication-score 0)
  (each [game (input_data:gmatch "([^\n]+)")]
    (local (elf-move my-move) (game:match "(%u+) (%u+)"))
    ;; prediction strategy
    (match (win? [my-move elf-move])
      (true weight) (set by-prediction-score (+ by-prediction-score weight 6))
      (false weight) (set by-prediction-score (+ by-prediction-score weight))
      (:draw weight) (set by-prediction-score (+ by-prediction-score weight 3)))

    ;; indication strategy
    (match [elf-move my-move]
      [move :Y] (set by-indication-score (+ by-indication-score
                                            (select 2 (classify move)) 3))
      [move :X] (set by-indication-score (+ by-indication-score
                                            (select 2 (classify (find-losing move)))))
      [move :Z] (set by-indication-score (+ by-indication-score
                                            (select 2 (classify (find-winning move)))
                                            6))))
  
    (values by-prediction-score by-indication-score))

(with-open [input_file (io.open :rock_paper_scissors.txt :r)]
  (print (solve (input_file:read "*all"))))
