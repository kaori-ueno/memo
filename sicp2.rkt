#lang racket

(define (average x y)
  (/ (+ x y) 2))

;Q2.1
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d))))
    (if (> d 0)
        (cons (/ n g) (/ d g))
        (cons (/ (- n) g) (/ (- d) g)))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (add-rat x y)
  (make-rat (+ (* numer x) (denom y)
               (* numer y) (denom x))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* numer x) (denom y)
               (* numer y) (denom x))
            (* (denom x) (denom y))))

;　Q2.2

(define (make-point x y)
  (cons x y))

(define (x-point x) (car x))

(define (y-point x) (cdr x))

(define (midpoint x y)
  (make-point
   (average (x-point x) (x-point y))
   (average (y-point x) (y-point y))))

(define (make-segment start end)
  (cons start end))

(define (start-segment x) (car x))

(define (end-segment x) (cdr x))

(define (midpoint-segment x)
  (midpoint (start-segment x) (end-segment x)))

; Q2.3

(define (make-rect x y)
  (cons x y))

(define (first-point x) (car x))

(define (second-point x) (cdr x))

(define (x-length rect)
  (abs (- (x-point (first-point rect)) (x-point (second-point rect)))))

(define (y-length rect)
  (abs (- (y-point (first-point rect)) (y-point (second-point rect)))))

(define (perimeter rect)
  (* 2 (+ (x-length rect) (y-length rect))))

(define (area rect)
  (* (x-length rect) (y-length rect)))

;------------------------------

(define (make-rect2 point x-length y-length)
  (cons point (cons x-length y-length)))

(define (first-point2 rect) (car rect))

(define (second-point2 rect)
  (make-point
   (+ (x-point (first-point2 rect)) (x-length rect))
   (+ (y-point (first-point2 rect)) (y-length rect))))

(define (x-length2 rect) (car (cdr rect)))

(define (y-length2 rect) (cdr (cdr rect)))

(define (perimeter2 rect)
  (* 2 (+ (x-length2 rect) (y-length2 rect))))

(define (area2 rect)
  (* (x-length2 rect) (y-length2 rect)))

; Q2.4

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

; Q2.5

(define (cons2 x y)
  (* (expt  2 x) (expt 3 y)))

(define (car2 z)
  (define (itr z ans)
    (if (= 0 (remainder z 2))
        (itr (/ z 2) (+ ans 1))
        ans))
  (itr z 0))

(define (cdr2 z)
  (define (itr z ans)
    (if (= 0 (remainder z 3))
        (itr (/ z 3) (+ ans 1))
        ans))
  (itr z 0))

; Q2.6

(define zero
  (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one
  (lambda (f) (lambda (x) (f x))))

(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define (plus m n)
  ((m add-1) n))

;---------------------
; 2.1.4
;---------------------

(define (print-center-percent i)
  (display "center:  ")
  (display (center i))
  (display "\npercent: ")
  (display (percent i)))

; Q2.7

(define (make-interval a b)
   (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

; Q2.8

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
                 (- (upper-bound x) (upper-bound y))))

; Q2.9
; 1 2 3  3 4 5  2  2
; multi
; 1,2,3  3,4,5  3,9,15
; 1,2,3  2,3,4  2,7,12
; div
; 6,7,8  2,3,4  2,2.5,3
; 10,11,12  2,3,4  3,4,5

; Q2.10
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (< (* (upper-bound y) (lower-bound y)) 0)
      (error "interval spans zero")
      (mul-interval x (make-interval (/ 1.0 (upper-bound y))
                          (/ 1.0 (lower-bound y))))))

; (-, -) (+, +) = (min1 * min2, max1 * max2)
; (-, +) (+, +) = (min1 * max2, max1 * max2)
; (-, +) (-, +) = ((min1 * min2) or (max1 * max2),
;                  (min1 * max2) or (max2 * min1)))
;

; Q2.11
; メモにて場合分け完了
; + + + +
; - + + +
; + + - +
; - - + +
; - + - + ← 乗算4回必要
; + + - -
; - - - +
; - + - -
; - - - -

; Q2.12

(define (make-center-percent c p)
  (define w (* c (/ p 100.0)))
  (make-interval (- c w) (+ c w)))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (percent i)
  (* (/ (width i) (center i)) 100.0))

; Q2.14

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))