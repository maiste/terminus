(*—————————————————————————————————————————————————————————————————————
   Copyright (c) 2022-* Etienne Marais <etienne@maiste.fr>
   Distributed under the MIT license. See terms at the end of this
   file.
  ————————————————————————————————————————————————————————————————————*)

(** The query type defines the interaction with the API:

    - [Get path]: tries to execute the GET method on a specific path in the API
    - [Post (path, expected)] defines a POST method on a path and verify the
      input with [expected].
    - [Put (path, expected)] works the same way as [Post]
    - [Delete path] executes a DELETE method on a specific path *)
type query =
  | Get of string
  | Post of string * string
  | Put of string * string
  | Delete of string
[@@deriving show]

exception Wrong_url of string
(** Exception raised when you are trying to execute a request on a wrong url or
    when urls mismatched. *)

exception Wrong_header of string
(** Exception raised when on field in an header mismatch. *)

module type Mock_backend = S.Intf with type 'a io = 'a
(** A Mock backend is an implementation of the {!S} module with a mock backend. *)

val mock :
  address:string ->
  expected_headers:(string * string) list ->
  expect:(query * string) list ->
  unit ->
  (module Mock_backend)
(** [mock ~address ~expected_headers ~expect ()] creates a new mock backend with
    some checks in it. The [address] is the endpoint for the API. the
    [expected_headers] are the data that should be found at each request in the
    header. [expect] is a list of {!query} with the answer expected when you
    execute the request. *)

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
