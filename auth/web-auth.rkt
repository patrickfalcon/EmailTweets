#lang racket
;; Simple authorisation with web integration
(require json)

(provide
 webKey
 localKey
 open-key
 key-exists?
 load-web
 paired?)

(define localKey null)
(define webKey null)
(define keyFile null)

(define (open-key v1)
  (set! keyFile (call-with-input-file v1 read-json))
  (set! localKey (get 'localKey)))

(define (paired?)
  (not (null? webKey)))

(define (load-web)
  (cond
    ((key-exists?)
     (set! webKey (get 'webKey))
     )
    (#t
     (raise "Missing pair"))
    )
  )

(define (key-exists?)
  (not (null? keyFile)))

(define (get v1)
  (hash-ref keyFile v1))

(define (get-value v1 v2)
  (list-ref (hash->list (get v1) (- v2 1))))

(define (lower-value v1 v2)
  (hash-ref (hash-ref keyFile v1) v2))