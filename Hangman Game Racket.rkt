;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Hangman Game Racket|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor mixed-fraction #f #t none #f () #t)))


(define (play-hangman word)
  (let ((word-length (string-length word))
        (tries 3)
        (guessed ""))))
    (displayln "Welcome to Hangman!")
    (displayln "Try to guess the word by entering one letter at a time.")
    (newline)
    (displayln (format "The word has ~a letters." word-length))
    (newline)
    (displayln (format "You have ~a tries." tries))
    (newline)
    
    (define (display-word)
      (let loop ((i 0))
        (when (< i word-length)
          (display (if (string-contains? guessed (string-ref word i))
                       (string-ref word i)
                       "_"))
          (display " ")
          (loop (+ i 1)))))
    
    (define (get-guess)
      (display "Enter a letter: ")
      (read-line))
    
    (define (update-guessed guess)
      (set! guessed (string-append guessed guess)))
    
    (define (update-tries)
      (set! tries (- tries 1)))
    
    (define (game-over?)
      (or (string=? guessed word)
          (= tries 0)))
    
    (define (play-round)
      (display-word)
      (newline)
      (let ((guess (get-guess)))
        (cond
          ((string-contains? guessed guess)
           (displayln "You already guessed that letter. Try again.")
           (play-round))
          ((string-contains? word guess)
           (update-guessed guess)
           (when (string=? guessed word)
             (displayln "Congratulations! You guessed the word!")
             (newline)))
          (else
           (update-tries)
           (displayln "Wrong guess!")
           (displayln (format "You have ~a tries left." tries))
           (newline)
           (when (= tries 0)
             (displayln (format "Game over! The word was ~a." word))
             (newline)))))
    
    (let loop ((round 1))
      (when (<= round tries)
        (displayln (format "Round ~a" round))
        (play-round)
        (newline)
        (unless (game-over?)
          (loop (+ round 1))))))

;; Example usage:
(play-hangman "racket")
