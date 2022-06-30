(** This module gathers all the methods you need to be able to execute HTTP
    requests to contact an API server. It must send application/json request. *)

type error = [ `Msg of string ]
type headers = (string * string) list

module type Intf = sig
  type 'a io
  (** The I/O monad used to execute HTTP request. *)

  val return : 'a -> 'a io
  val map : ('a -> 'b) -> 'a io -> 'b io
  val bind : ('a -> 'b io) -> 'a io -> 'b io
  val fail : error -> 'a io

  val get : headers:headers -> url:string -> string io
  (** [get ~headers ~url] executes a request to the server as a [GET] call and,
      returns the result as a {!string}. *)

  val post : headers:headers -> url:string -> string -> string io
  (** [post ~headers ~url body] executes a request to the server as a [POST]
      call using {!body} to describe the request. It returns the result as a
      {!string}. *)

  val put : headers:headers -> url:string -> string -> string io
  (** [put ~headers ~url body] executes a request to the server as a [PUT] call
      using {!body} to describe the request. It returns the result as a
      {!string}. *)

  val delete : headers:headers -> url:string -> string io
  (** [delete ~headers ~url] executes a request to the server as a [DELETE] call
      and returns the result as a {!string}. *)
end
