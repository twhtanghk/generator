{uniqBy} = require('../index').default

g = (min, max) ->
  i = min
  while i < max
    yield i: i++, time: Date.now()

f = (i) ->
  i % 2 == 1

do ->
  for await i from uniqBy(g, 'time') 100, 200
    console.log i
