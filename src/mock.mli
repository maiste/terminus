type query =
  | Get of string
  | Post of string * string
  | Put of string * string
  | Delete of string
[@@deriving show]

exception Wrong_url of string
exception Wrong_header of string

module type Mock_backend = S.Intf with type 'a io = 'a

val mock :
  address:string ->
  expected_headers:(string * string) list ->
  expect:(query * string) list ->
  unit ->
  (module Mock_backend)
