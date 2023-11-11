#lang racket
(require json)
(require "hash.rkt")
(require "token.rkt")

;; because token->hash returns positions as vectors, we need to convert
;; them so they are accepted as a jsexpr by json
;; https://docs.racket-lang.org/json/index.html#%28def._%28%28lib._json%2Fmain..rkt%29._jsexpr~3f%29%29
(define (token->jsexpr token)
  (let ([token-hash (token->hash token)])
    (foldl
      (lambda [sym hsh] (hash-update hsh sym vector->list))
      token-hash
      '(start end))))

;; utf-8 of tokens
(define (tokens->json tokens)
  (jsexpr->bytes
    (sequence->list
      (sequence-map
        token->jsexpr
        tokens))))

(provide tokens->json)
