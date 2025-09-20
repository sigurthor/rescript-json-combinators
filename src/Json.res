module Encode = Json_Encode
module Decode = Json_Decode

exception ParseError(string)

let decode = Decode.decode

let parse = str =>
  try Ok(str->Js.Json.parseExn) catch {
  | JsExn(exn) => Error(exn->JsExn.message->Js.Option.getWithDefault("Unknown error", _))
  }

let parseExn = str =>
  try str->Js.Json.parseExn catch {
  |  JsExn(exn) =>
    throw(ParseError(exn->JsExn.message->Js.Option.getWithDefault("Unknown error", _)))
  }

@val external stringify: Js.Json.t => string = "JSON.stringify"
