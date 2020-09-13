#lang racket

(define (sum term A next B)
    (if (> A B)
        0
        (+ (term A) (sum term (next A) next B))))

(define (sq X)
    (* X X))

(define (plus1 A)
    (+ 1 A))

(define (sum-int A B)
    (define (identify X) X)
    (sum identify A plus1 B))

(define (sum-sq A B)
    (sum sq A plus1 B))

(define (pi-sum A B)
    (sum (lambda(i) (/ 1 (* i (+ i 2))))
         A
         (lambda(i) (+ i 4))
         B))

(define (fixed-point f start)
    (define tolerance 0.000000001)
    (define (close-enuf? u v)
        (< (abs (- u v)) tolerance))
    (define (iter old new)
        (if (close-enuf? old new)
            new
            (iter new (f new))))
    (iter start (f start)))
;;SICP有个特色就是会想办法用尾递归……

(define (average x y)
    (/ (+ x y) 2))

(define average-damp (lambda(f) (lambda(x) (average (f x) x))))

(define (sqrt x)
    (fixed-point (average-damp (lambda(y) (/ x y))) 1))
;;这样应该没啥问题了吧……

(sqrt 2)