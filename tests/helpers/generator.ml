module J = Ezjsonm

module MakeTest
    (Http : Terminus.S) (Config : sig
      val port : int
    end) =
struct
  let port = Config.port

  let headers =
    [ ("X-Auth-Token", "mytoken"); ("Content-Type", "application/json") ]

  let url = "http://localhost:" ^ string_of_int port
  let return x = Http.return x
  let ( let* ) m f = Http.bind f m

  let test_get _ () =
    let* json = Http.get ~url ~headers in
    let json = Ezjsonm.value_from_string json in
    let id = J.find json [ "id" ] |> J.get_int in
    Alcotest.(check int "gather id from get" id 1);
    return ()

  let test_post _ () =
    let body =
      `O
        [
          ("title", `String "foo");
          ("body", `String "bar");
          ("userId", `Float 1.0);
        ]
      |> J.value_to_string
    in
    let* json = Http.post ~url ~headers body in
    let json = Ezjsonm.value_from_string json in
    let id = J.find json [ "userId" ] |> J.get_int in
    Alcotest.(check int "gather id from post" id 1);
    return ()

  let test_put _ () =
    let body =
      `O
        [
          ("title", `String "foo");
          ("body", `String "bar");
          ("userId", `Float 1.0);
        ]
      |> J.value_to_string
    in
    let* json = Http.put ~url ~headers body in
    let json = Ezjsonm.value_from_string json in
    let id = J.find json [ "userId" ] |> J.get_int in
    Alcotest.(check int "gather userId from put" id 1);
    return ()

  let test_delete _ () =
    let* _ = Http.delete ~url ~headers in
    return ()

  (* Main *)

  let run ~exec name =
    let name = Format.sprintf "Http %s module" name in
    let quick name test =
      Alcotest.test_case name `Quick (fun x -> exec (test x))
    in
    Alcotest.(
      run name
        [
          ( "call",
            [
              quick "GET Method" test_get;
              quick "POST Method" test_post;
              quick "PUT Method" test_put;
              quick "DELETE Method" test_delete;
            ] );
        ])
end
