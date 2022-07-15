(*—————————————————————————————————————————————————————————————————————
   Copyright (c) 2022-* Etienne Marais <etienne@maiste.fr>
   Distributed under the MIT license. See terms at the end of this
   file.
  ————————————————————————————————————————————————————————————————————*)

module Client = Http_lwt_client

type nonrec 'a io = ('a, [ `Msg of string ]) Lwt_result.t

let return = Lwt_result.return
let map = Lwt_result.map
let bind f m = Lwt_result.bind m f
let fail e = Lwt_result.fail e

(***** Helpers *****)

let get_body = function
  | Ok (_, None) -> return ""
  | Ok (_, Some body) -> return body
  | Error e -> fail e

let ( =<< ) f m = Lwt.bind m f

(**** Http methods ****)

let get ~headers ~url = get_body =<< Client.one_request ~meth:`GET ~headers url

let post ~headers ~url body =
  get_body =<< Client.one_request ~meth:`POST ~headers ~body url

let put ~headers ~url body =
  get_body =<< Client.one_request ~meth:`PUT ~headers ~body url

let delete ~headers ~url =
  get_body =<< Client.one_request ~meth:`DELETE ~headers url

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
