#lang racket

;;racket没有自带atom?需要自行编写
(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

(define (DERIV EXP VAR)
  (cond((CONSTANT? EXP VAR) 0)
       ((SAME-VAR? EXP VAR) 1)
       ((SUM? EXP)
        (MAKE-SUM (DERIV (A1 EXP) VAR)
                  (DERIV (A2 EXP) VAR)))
       ((PRODUCT? EXP)
        (MAKE-SUM
         (MAKE-PRODUCT (M1 EXP)
                       (DERIV (M2 EXP) VAR))
         (MAKE-PRODUCT (M2 EXP)
                       (DERIV (M1 EXP) VAR))))))

(define (CONSTANT? EXP VAR)
  (and (atom? EXP)
       (not (eq? EXP VAR))))

;;本来写错了还行
(define (SAME-VAR? EXP VAR)
  (and (atom? EXP)
       (eq? EXP VAR)))

(define (SUM? EXP)
  (and (not (atom? EXP))
       (eq? (car EXP) '+)))

(define (MAKE-SUM a1 a2)
  (cond ((and (number? a1)
              (number? a2))
         (+ a1 a2))
        ((and (number? a1) (= a1 0))
         a2)
        ((and (number? a2) (= a2 0))
         a1)
        (else (list '+ a1 a2))))

(define A1 cadr)
(define A2 caddr)

(define (PRODUCT? EXP)
  (and (not (atom? EXP))
       (eq? (car EXP) '*)))

(define (MAKE-PRODUCT m1 m2)
  (cond ((and (number? m1)
              (number? m2))
         (* m1 m2))
        ((and (number? m1) (= m1 0))
         0)
        ((and (number? m2) (= m2 0))
         0)
        ((and (number? m1) (= m1 1))
         m2)
        ((and (number? m2) (= m2 1))
         m1)
        (else (list '* m1 m2))))
(define M1 cadr)
(define M2 caddr)

(define foo
  ' (* x x))

(DERIV foo 'x)
