{lookBack, uniqBy} = require('../index').default

g = (min, max) ->
  i = min
  while i < max
    yield i: i++, time: Date.now()

f = (i) ->
  i % 2 == 1

do ->
  for await {i, chunk} from lookBack(uniqBy(g), 5) 100, 4000
    console.log i, chunk
