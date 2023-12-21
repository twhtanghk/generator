{map} = require('../index').default

console.log map

g = (min, max) ->
  i = min
  while i < max
    yield i++

f = (n) ->
  n + 2

do ->
  for await i from map(g, f) 100, 105
    console.log i
