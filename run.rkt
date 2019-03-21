#lang racket

(require "lib/tweet.rkt"
         "lib/map-lib.rkt"
         "auth/web-auth.rkt"
         net/head)

;; Authorisation using key stored in JSON file
(open-key "auth/key.json")
(pair-web)

(define (!contains? v1 v2)
  (not (string-contains? v1 v2)))

(define body null)
(define (email-tweet)
  
  (cond
    ((imap-pending-expunges? imap) (imap-expunge imap) (imap-reselect imap "INBOX") (print "- EXPUNGED -"))
    ((string-contains? (extract-field "Subject" (decode (get-message (mid 0) '(header)))) "tweet: ")
     
     (tweet (substring (extract-field "Subject" (decode (get-message (mid 0) '(header)))) 7 (string-length (extract-field "Subject" (decode (get-message (mid 0) '(header)))))))
     (print "- POSTED -")
     
     (mark-for-delete 0)
     )
    )
  (sleep 0.05)
  (imap-expunge imap)
  (email-tweet)
  )
