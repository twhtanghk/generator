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

export default generator
