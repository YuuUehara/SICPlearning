#lang racket

;;尾递归的fibnacci，保证时间复杂度

(define (fib x)
    (fib-add x 1 0))

(define (fib-add n next res)
    (if (= n 0)
        res
        (fib-add (- n 1) (+ next res) next)))

(fib 10)