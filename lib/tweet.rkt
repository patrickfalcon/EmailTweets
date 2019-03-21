#lang racket

(require "auth.rkt")

(provide
 twitter-connect
 connected?
 disconnect!
 grab-tweets
 tweet
 follow-person
 unfollow-person
 )

(define twitter-connect null)
(define (connected?) (null? twitter-connect))
(define (disconnect!) (set! twitter-connect null))

(define (connect-to-auth v1 v2 v3 v4)

  (set! twitter-connect (new oauth-single-user%
                             [consumer-key v1]
                             [consumer-secret v2]
                             [access-token v3]
                             [access-token-secret v4]))
  )

;; General idea
;; Parses information on a JSON file that will be sent to the twitter api.

(define (grab-tweets v1)
  (send twitter-connect get-request
        "https://api.twitter.com/1.1/search/tweets.json"
        (list (cons 'q v1))))

(define (tweet v1)
  (send twitter-connect post-request "https://api.twitter.com/1.1/statuses/update.json"
        (list (cons 'status v1))))

(define (follow-person v1)
  (send twitter-connect post-request "https://api.twitter.com/1.1/friendships/create.json"
        (list (cons 'screen_name v1) (cons 'follow "true"))))

(define (unfollow-person v1)
  (send twitter-connect post-request "https://api.twitter.com/1.1/friendships/create.json"
        (list (cons 'screen_name v1) (cons 'follow "false"))))

(connect-to-auth
   "XXXXXX"
   "XXXXXX"
   "XXXXXX"
   "XXXXXX")