let port = 55421

open Helpers

module Test =
  Generator.MakeTest
    (Terminus_hlc)
    (struct
      let port = port
    end)

let exec m =
  match Lwt_main.run (Server.with_server ~port m ()) with
  | Ok v -> v
  | Error (`Msg m) -> failwith m

let () = Test.run ~exec "Http-lwt-client"
