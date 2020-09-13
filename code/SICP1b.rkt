#lang racket

(define (SOS X Y)
    (+ (SQ X) (SQ Y)))

(define (SQ X)
    (* X X))

(SOS 3 4)