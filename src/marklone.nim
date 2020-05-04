import httpclient, parseopt, os

proc cloneMarkdown(link: string) =
  try:
    var
      client = newHttpClient()
      file = open("clone.md", fmWrite)
    defer: file.close()
    file.write(client.getContent(link))
    echo("Success : Check out clone.md.")
  except IOError as err:
    echo("error : " & err.msg)

proc help() =
  echo """
  MarKlone 1.0.0
  Option:
  - h | --help     : show help
  - v | --version  : show version
  """

proc version() =
  echo "MarKlone 1.0.0"

proc error() =
  echo "Error option"

proc main*() =
  var url: string

  if paramCount() == 0:
    help()
    quit(0)

  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      url = key
    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h":
        help()
        quit()
      of "version", "v":
        version()
        quit(0)
      else:
        error()
        quit(0)
    else:
      discard

  cloneMarkdown(url)

when isMainModule:
  main()