{reduce} = require('../index').default

g = (min, max) ->
  i = min
  while i < max
    yield i++

f = (i, initVal=0) ->
  initVal + i

do ->
  for await i from reduce(g, f, 2) 100, 105
    console.log i
