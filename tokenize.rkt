#lang racket

;; require pyffi with members prefixed as py/
(require (prefix-in py/ pyffi))

;; load the python interpreter
;; https://soegaard.github.io/pyffi/An_introduction_to_pyffi.html
(py/initialize)
(py/post-initialize)

;; load the tokenizer
;; https://docs.python.org/3/library/tokenize.html
(py/import tokenize)

;; load python's io library
(py/import io)

;; native tokenization method helpers
(define py/str->bytesio
  (py/run "lambda s: io.BytesIO(s.encode('utf-8'))"))

(define py/bytesio->token-generator
  (py/run "lambda io: tokenize.tokenize(io.readline)"))

(define (py/token-seq py-src)
  (py/in-pygenerator
    (py/bytesio->token-generator
      (py/str->bytesio py-src))))

(define (py/token-list py-src)
  (sequence->list (py/token-seq py-src)))

;; Provide tokenizer as py/token-seq
(provide py/token-seq)

;; Provide tokenizer as py/token-list
(provide py/token-list)
