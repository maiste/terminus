(*—————————————————————————————————————————————————————————————————————
   Copyright (c) 2022-* Etienne Marais <etienne@maiste.fr>
   Distributed under the MIT license. See terms at the end of this
   file.
  ————————————————————————————————————————————————————————————————————*)

(** It provides an API call system relying on {!Http_lwt_client}. *)

include Terminus.S with type 'a io = ('a, [ `Msg of string ]) Lwt_result.t
(** @inline *)

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
