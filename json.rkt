#lang racket
(require json)
(require "token.rkt")

(define (token->json token)
  (let ([token-hash (token->hash token)])
    (jsexpr->bytes token-hash)))

(define (tokens->json tokens)
  (map token->json tokens))

(provide token->json)
(provide tokens->json)

