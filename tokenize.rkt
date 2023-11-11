#!/usr/bin/env racket
#lang racket

(require "lib/hash.rkt")
(require "lib/json.rkt")
(require "lib/tokenize.rkt")

(define args (current-command-line-arguments))

(define (print-usage)
   (display "Usage: ./tokenize.rkt <fmt:{json, rkt-list, rkt-hash}> '<py-src>'" (current-error-port))
   (display "\n\nExamples:" (current-error-port))
   (display "\n    Simplest example that shows tokens for `def hi(): pass`" (current-error-port))
   (display "\n    $ ./tokenize.rkt json 'def hi(): pass'" (current-error-port))
   (display "\n\n    Reading in a python file:" (current-error-port))
   (display "\n    $ ./tokenize.rkt rkt-list \"$(cat prog.py)\"" (current-error-port))
   (display "\n\n    This one is quite fun -- tokenize python's tokenizer:`" (current-error-port))
   (display "\n    $ ./tokenize.rkt json \"$(curl -s https://raw.githubusercontent.com/python/cpython/3.12/Lib/tokenize.py)\" | jq | less" (current-error-port))
   (display "\n\nBuilt with gratitude to the pyffi library https://github.com/soegaard/pyffi."))

(cond
 [(not (equal? (vector-length args) 2)) ((print-usage) (exit 1))])

(define fmt (vector-ref args 0))
(define py-src (vector-ref args 1))

(match fmt
  ["json" (display (tokens->json (tokenize py-src)))]
  ["rkt-list" (display (sequence->list (tokenize py-src)))]
  ["rkt-hash" (display (sequence->list (sequence-map token->hash (tokenize py-src))))]
  [_ ((print-usage) (exit 1))]) 




