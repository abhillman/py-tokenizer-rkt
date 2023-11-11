#lang racket

;; require pyffi with members prefixed as pyffi/
(require (prefix-in pyffi/ pyffi))

;; provides token struct and related utils
(require (prefix-in token/ "token.rkt"))

;; load the python interpreter
;; https://soegaard.github.io/pyffi/An_introduction_to_pyffi.html
(pyffi/initialize)
(pyffi/post-initialize)

;; load the tokenizer
;; https://docs.python.org/3/library/tokenize.html
(pyffi/run* "import tokenize")

;; load python's io library
(pyffi/import io)

;; native tokenization method helpers
(define py:str->bytesio
  (pyffi/run "lambda s: io.BytesIO(s.encode('utf-8'))"))

(define py:bytesio->token-generator
  (pyffi/run "lambda io: tokenize.tokenize(io.readline)"))

;; tokenizer which returns seq of python tokens
;; https://docs.python.org/3/library/tokenize.html
(define (tokenize-raw py-src)
  (pyffi/in-pygenerator
    (py:bytesio->token-generator
      (py:str->bytesio py-src))))

;; tokenizer which returns native struct of tokens
(define (tokenize py-src)
  (sequence-map token/pytoken->token
                (tokenize-raw py-src)))

;; Provide tokenizer
(provide tokenize)
