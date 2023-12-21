{filter} = require('../index').default

g = (min, max) ->
  i = min
  while i < max
    yield i++

f = (i) ->
  i % 2 == 1

do ->
  for await i from filter(g, f) 100, 105
    console.log i
