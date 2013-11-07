{compress, decompress} = LZString = require("../main")

# TODO: Test other compression methods

describe "LZString", ->
  it "compresses and decompresses \"Hello world!\"", ->
    compressed = compress("Hello world!")
    decompressed = decompress(compressed)

    assert.equal decompressed, "Hello world!"

  it "compresses and decompresses null", ->
    compressed = compress(null)
    assert.equal compressed, ""

    decompressed = decompress(compressed)
    assert.equal decompressed, null

  it "compresses and decompresses an empty string", ->
    compressed = compress("")

    decompressed = decompress(compressed)
    assert.equal decompressed, ""

  it "compresses and decompresses all printable UTF-16 characters", ->
    testString = ""
    i = undefined
    i = 32
    while i < 127
      testString += String.fromCharCode(i)
      ++i
    i = 128 + 32
    while i < 55296
      testString += String.fromCharCode(i)
      ++i
    i = 63744
    while i < 65536
      testString += String.fromCharCode(i)
      ++i

    compressed = compress(testString)

    decompressed = decompress(compressed)
    assert.equal decompressed, testString

  it "compresses and decompresses a string that repeats", ->
    testString = "aaaaabaaaaacaaaaadaaaaaeaaaaa"
    compressed = compress(testString)

    assert compressed.length < testString.length

    decompressed = decompress(compressed)
    assert.equal decompressed, testString

  it "compresses and decompresses a long string", ->
    testString = ""

    i = 0
    while i < 1000
      testString += Math.random() + " "
      i++

    compressed = compress(testString)

    assert compressed.length < testString.length
    decompressed = decompress(compressed)
    assert.equal decompressed, testString
