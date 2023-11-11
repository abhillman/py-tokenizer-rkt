#lang racket

;; allows us to select requires via regex
(require racket/require)

;; only match `token-type`, `token-str`, etc.
(require (matching-identifiers-in #rx"token-\\w*" "token.rkt"))

;; converts a token to a hash
(define (token->hash token)
  (hash
    'type (token-type token)
    'string (token-str token)
    'start (token-start token)
    'end (token-end token)
    'line (token-line token)))

(provide token->hash)
