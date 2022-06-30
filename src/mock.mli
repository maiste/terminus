type query =
  | Get of string
  | Post of string * string
  | Put of string * string
  | Delete of string
[@@deriving show]

val mock :
  address:string ->
  expected_headers:(string * string) list ->
  expect:(query * string) list ->
  unit ->
  (module S.Intf)
