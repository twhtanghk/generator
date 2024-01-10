import {uniqBy} from 'lodash'

generator =
  map: (g, f) ->
    (...args) ->
      for await i from g ...args
        yield await f i
  reduce: (g, f, value) ->
    (...args) ->
      g = await g ...args
      if not value?
        {value, done} = g.next()
      for await i from g
        value = await f i, value
        yield value
  filter: (g, f) ->
    (...args) ->
      for await i from g ...args
        if await f i
          yield i
  # look back n elements from generator
  # yield i th element and last n elements from the generator
  lookBack: (g, n=5) ->
    (...args) ->
      chunk = []
      for await i from g ...args
        chunk.push i
        if chunk.length > n
          chunk.shift()
        yield {i, chunk}
  # look back from generator
  # yield i th element and filter those duplicate elements
  uniqBy: (g, iteratee='timestamp') ->
    (...args) ->
      last = null
      for await i from g ...args
        ret = uniqBy [i, last], iteratee 
        if last? and ret.length == 2
          yield last
        last = i

export default generator
