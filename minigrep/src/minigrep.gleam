import gleam/io
import gleam/string
import gleam/result
import gleam/erlang
import gleam/erlang/os
import search

pub fn main() {
  let result = {
    try config =
      search.build_config(erlang.start_arguments(), os.get_all_env())
      |> add_error_prefix("Problem parsing arguments")
    search.run(config)
    |> add_error_prefix("Application error")
  }
  case result {
    Ok(_) -> Nil
    Error(message) -> io.println(message)
  }
}

fn add_error_prefix(
  to result: Result(any, String),
  with prefix: String,
) -> Result(any, String) {
  result.map_error(
    result,
    fn(error) {
      prefix
      |> string.append(": ")
      |> string.append(error)
    },
  )
}
