type query =
  | Get of string
  | Post of string * string
  | Put of string * string
  | Delete of string
[@@deriving show]

exception Wrong_url of string
exception Wrong_token of string

module Http_mock (M : sig
  val address: string
  val check_headers: (string * string) list -> bool
  val expect : (query * string) list
end) =
struct
  type 'a io = 'a

  let return x = x
  let bind f x = f x
  let map f x = f x
  let fail (`Msg m) = failwith m

  let address = M.address

  module Mocks = Map.Make (struct
    type t = query

    let compare = Stdlib.compare
  end)

  let mocks = Mocks.of_seq @@ List.to_seq @@ M.expect

  let address_length = String.length address

  let check_headers headers =
      assert (M.check_headers headers)

  let starts_with ~prefix str =
    let len = String.length prefix in
    String.length str >= len && String.sub str 0 len = prefix

  let extract_path url =
    if starts_with ~prefix:address url then
      String.sub url address_length (String.length url - address_length)
    else raise (Wrong_url url)

  let find key =
    try Mocks.find key mocks
    with Not_found ->
      failwith (Printf.sprintf "Not_found %s" ("TODO"))

  let compute ~headers ~url fn =
    check_headers headers;
    let path = extract_path url in
    find (fn ~path)

  let get = compute (fun ~path -> Get path)
  let delete = compute (fun ~path -> Delete path)

  let post ~headers ~url body =
    compute ~headers ~url (fun ~path -> Post (path, body))

  let put ~headers ~url body =
    compute ~headers ~url (fun ~path -> Put (path, body))
end
