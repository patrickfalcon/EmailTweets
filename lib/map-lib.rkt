#lang racket

(require racket/list openssl/mzssl net/imap net/head "useless-dir.rkt")

(provide
 imap
 mid
 get-message
 uid
 header-info
 decode
 refresh
 unsafe-disconnect
 connect
 mark-for-delete
 imap-expunge
 imap-get-expunges
 imap-pending-expunges?
 imap-reset-new!
 imap-reselect
 )

(define priorities (make-vector 1))
(vector-set! priorities 0 "live.mdx.ac.uk")

(define (unsafe-disconnect)
  (print "Client forced connection to close")
  (imap-force-disconnect imap))

(define (refresh)
  (cond
    ((refresh?) (imap-expunge imap))))

(define pI 0)
(define (is-priority? v1)
  (for ([i (vector-length priorities)])
    (string-contains? v1 (vector-ref priorities i))))

(define imap-server "imap-mail.outlook.com")
(define imap-port-no 993)
(define username "pf313@live.mdx.ac.uk")
(define pw password)
(define mailbox-name "INBOX")

(define (mark-for-delete v1)
  (imap-store imap '! (list (mid 0)) (list (symbol->imap-flag 'deleted)))
  (imap-expunge imap)
  )

(define (connect)
  (let ([c (ssl-make-client-context)])
    (let-values ([(in out) (ssl-connect imap-server imap-port-no c)])
      (imap-connect* in out username pw mailbox-name))))


(define-values [imap messages recent] (connect))

(define (refresh?)
  (imap-pending-expunges? imap))

(define (header-info v1)
  (get-message v1 '(header)))
(define (uid v1)
  (get-message v1 '(uid)))


(define (decode v1)
  (bytes->string/utf-8 (first (first v1))))

(define (!messages) (imap-messages imap))
(define (mid v1) (- (!messages) v1))
(define (get-message v1 v2) (cond
                              ((list? v2) (imap-get-messages imap (list v1) v2))
                              (#t (imap-get-messages imap (list v1) (list v2)))))