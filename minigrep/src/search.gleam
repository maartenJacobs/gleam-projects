import gleam/io
import gleam/string
import gleam/list
import gleam/map
import gleam/erlang/file

pub opaque type Config {
  Config(file_path: String, query: String, ignore_case: Bool)
}

pub fn build_config(
  args: List(String),
  env: map.Map(String, String),
) -> Result(Config, String) {
  case args {
    [query, file_path] ->
      Ok(Config(
        query: query,
        file_path: file_path,
        ignore_case: map.has_key(env, "IGNORE_CASE"),
      ))
    _ -> Error("unexpected arguments")
  }
}

pub fn run(config: Config) -> Result(Nil, String) {
  case file.read(config.file_path) {
    Ok(contents) -> {
      case config.ignore_case {
        True -> search_case_insensitive(contents, config.query)
        False -> search(contents, config.query)
      }
      |> list.each(fn(result) { io.println(result) })
      Ok(Nil)
    }
    Error(_e) -> Error("unable to read file")
  }
}

pub fn search(contents: String, query: String) -> List(String) {
  contents
  |> string.split(on: "\n")
  |> list.filter(fn(line) { string.contains(line, query) })
}

pub fn search_case_insensitive(contents: String, query: String) -> List(String) {
  let query = string.lowercase(query)

  contents
  |> string.split(on: "\n")
  |> list.filter(fn(line) {
    line
    |> string.lowercase()
    |> string.contains(query)
  })
}
