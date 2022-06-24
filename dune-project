(lang dune 3.0)
(generate_opam_files true)

(name backroom)
(source (github maiste/backroom))
(license MIT)
(authors
  "Étienne Marais <etienne@maiste.fr>")
(maintainers
  "Étienne Marais <etienne@maiste.fr>")
(documentation "maiste.github.io/backroom")

(package
  (name backroom)
  (synopsis "A Simple Backend to build RestAPI")
  (description "Backroom provides the basic functionalities for a RestAPI requester.")
  (depends
    (ocaml (>= 4.08.0))
    (ezjsonm (>= 1.3.0))
    (lwt (>= 5.3.0))
    (odate (>= 0.6))
    (alcotest :with-test)
    (alcotest-lwt :with-test)
    (ppx_deriving :with-test)
    (odoc :with-doc))
  (conflicts
    (result (< 1.5))))

(package
  (name backroom-hlc)
  (synopsis "Backroom with the http-lwt-client request handler")
  (description
    "Backroom-hlc is an implementation of the Backroom library using http-lwt-client.")
  (depends
    http-lwt-client
    (httpaf-lwt-unix :with-test)
    (alcotest :with-test)
    (alcotest-lwt :with-test)
    (odoc :with-doc))
  (conflicts
    (result (< 1.5))))

(package
  (name backroom-cohttp)
  (synopsis "Backroom with the cohttp-lwt-unix request handler")
  (description
    "Backroom-cohttp is an implementation of the Equinoxe library using cohttp-lwt-unix.")
  (depends
    cohttp-lwt-unix
    (httpaf-lwt-unix :with-test)
    (alcotest :with-test)
    (alcotest-lwt :with-test)
    (odoc :with-doc))
  (conflicts
    (result (< 1.5))))

