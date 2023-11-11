#lang racket

(require "token.rkt")
(require "tokenize.rkt")

(define (py/print-tokens py-src)
  (for ([token (py/token-seq py-src)])
    (print token)))

(provide py/print-tokens)

