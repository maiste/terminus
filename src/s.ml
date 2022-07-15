(*—————————————————————————————————————————————————————————————————————
   Copyright (c) 2022-* Etienne Marais <etienne@maiste.fr>
   Distributed under the MIT license. See terms at the end of this
   file.
  ————————————————————————————————————————————————————————————————————*)

(** This module gathers all the methods you need to be able to execute HTTP
    requests to contact an API server. It must send application/json request. *)

type error = [ `Msg of string ]
type headers = (string * string) list

module type Intf = sig
  type 'a io
  (** The I/O monad used to execute HTTP request. *)

  val return : 'a -> 'a io
  (** [return x] creates a value in the {!io} monad. *)

  val map : ('a -> 'b) -> 'a io -> 'b io
  (** [map f x] executes the [f] function and then wrap the result in the {!io}
      monad. *)

  val bind : ('a -> 'b io) -> 'a io -> 'b io
  (** [bind f x] is the same as {!map} but the function [f] should handle the
      binding into the {!io} monad. *)

  val fail : error -> 'a io
  (** [fail err] is the equivalent of {!return} but with a failure in the {!io}
      monad. *)

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
