#lang racket

;; Needed for fetching attributes; for more info:
;; * https://github.com/soegaard/pyffi/issues/2
;; * https://github.com/soegaard/pyffi/issues/3
(require (only-in pyffi [getattr pyffi/getattr]))

(struct pos
  (row col) #:transparent)

(struct token
  (type str start end line) #:transparent)

;; converts a pytoken to a racket token
;;; pytoken is a named 5-tuple
;;; https://docs.python.org/3/library/tokenize.html#tokenize.tokenize
(define (pytoken->token pytoken)
  (apply token
         (map
           (lambda [attr-name]
             (pyffi/getattr pytoken attr-name))
           '("type" "string" "start" "end" "line"))))

(provide pytoken->token)
(provide (struct-out token))
