type point = {
  x: int,
  y: int,
}

type polyline = {
  points: array<point>,
  thickness: option<int>,
  optional: option<int>,
  oneOf:option<int>
}

module Decode = {
  open Json.Decode

  let point = object(field => {
    x: field.required(. "x", int),
    y: field.required(. "y", int),
  })

  let polyline = object(field => {
    points: field.required(. "points", array(point)),
    thickness: field.optional(. "thickness", int),
    oneOf: field.oneOf(. [("oneOf",option(int))]),
    optional: field.optional(. "optinal",int)
  })
}

let data = `{
  "other": null,
  "oneOf": 1,
  "points": [
    { "x": 1, "y": -4 },
    { "x": 5, "y": 8 }
  ]
}`

let _ = data->Json.parseExn->Json.decode(Decode.polyline)->Js.log
