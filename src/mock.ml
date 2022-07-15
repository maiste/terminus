(*—————————————————————————————————————————————————————————————————————
   Copyright (c) 2022-* Etienne Marais <etienne@maiste.fr>
   Distributed under the MIT license. See terms at the end of this
   file.
  ————————————————————————————————————————————————————————————————————*)

type query =
  | Get of string
  | Post of string * string
  | Put of string * string
  | Delete of string
[@@deriving show]

exception Wrong_url of string
exception Wrong_header of string

module Http_mock (M : sig
  val address : string
  val expected_headers : (string * string) list
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
    List.iter
      (fun (field, value) ->
        match List.assoc_opt field headers with
        | None ->
            raise (Wrong_header (Format.sprintf "No value for field %s" field))
        | Some value' ->
            if value <> value' then
              raise
                (Wrong_header
                   (Format.sprintf "Values mismatches %s <> %s for field %s"
                      value value' field)))
      M.expected_headers

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
      failwith (Printf.sprintf "Not_found %s" (show_query key))

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

module type Mock_backend = S.Intf with type 'a io = 'a

let mock ~address ~expected_headers ~expect () =
  let module H = struct
    let address = address
    let expect = expect
    let expected_headers = expected_headers
  end in
  (module Http_mock (H) : Mock_backend)

(*——————————————————————————————————————————————————————————————————————
   Copyright (c) 2022-* Etienne Marais <etienne@maiste.fr>
   Permission to use, copy, modify, and/or distribute this software for
   any purpose with or without fee is hereby granted, provided that the
   above copyright notice and this permission notice appear in all copies.
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ————————————————————————————————————————————————————————————————————*)
