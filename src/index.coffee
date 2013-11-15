ngmin = require('ngmin')

module.exports = class NgminPreminifier
  brunchPlugin: yes
  type: 'javascript'

  optimize: (data, path, callback) ->
    try
      result = ngmin.annotate(data)
    catch err
      error = err
    finally
      callback(error, result)
