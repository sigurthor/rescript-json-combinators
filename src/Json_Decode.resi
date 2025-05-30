type t<'a>

type fieldDecoders = {
  optional: 'a. (. string, t<'a>) => option<'a>,
  required: 'a. (. string, t<'a>) => 'a,
  withDefault: 'a. (. 'a, string, t<'a>) => 'a,
  oneOf: 'a. (. array<(string, t<'a>)>) => 'a,
}

exception DecodeError(string)

module Error: {
  let expected: (string, Js.Json.t) => _
}

let custom: ((. Js.Json.t) => 'a) => t<'a>

let id: t<Js.Json.t>

let float: t<float>
let int: t<int>
let bool: t<bool>
let string: t<string>

let array: t<'a> => t<array<'a>>
let list: t<'a> => t<list<'a>>
let object: (fieldDecoders => 'a) => t<'a>
let option: t<'a> => t<option<'a>>

let date: t<Js.Date.t>
let pair: (t<'a>, t<'b>) => t<('a, 'b)>
let tuple2: (t<'a>, t<'b>) => t<('a, 'b)>
let tuple3: (t<'a>, t<'b>, t<'c>) => t<('a, 'b, 'c)>
let tuple4: (t<'a>, t<'b>, t<'c>, t<'d>) => t<('a, 'b, 'c, 'd)>
let dict: t<'a> => t<Js.Dict.t<'a>>
let keyArray: t<'a> => t<array<(string,'a)>>
let keyList: t<'a> => t<list<(string,'a)>>
let keyArrayValues: t<'a> => t<array<'a>>
let keyListValues: t<'a> => t<list<'a>>
let field: (string, t<'a>) => t<'a>

let oneOf: array<t<'a>> => t<'a>
let map: (t<'a>, (. 'a) => 'b) => t<'b>
let flatMap: (t<'a>, (. 'a) => t<'b>) => t<'b>

let indirect: (() => t<'a>) => t<'a>

let decode: (Js.Json.t, t<'a>) => result<'a, string>
