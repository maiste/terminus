let port = 4545

open Helpers

module Test =
  Generator.MakeTest
    (Terminus_cohttp)
    (struct
      let port = port
    end)

let exec m = Lwt_main.run (Server.with_server ~port m ())
let () = Test.run ~exec "Cohttp"
