import gleeunit/should
import search

pub fn search_case_sensitive_test() {
  let poem =
    "I'm nobody! Who are you?
Are you nobody, too?
Then there's a pair of us - don't tell!
They'd banish us, you know.

How dreary to be somebody!
How public, like a frog
To tell your name the livelong day
To an admiring bog!"

  should.equal(
    search.search(poem, "the"),
    [
      "Then there's a pair of us - don't tell!",
      "To tell your name the livelong day",
    ],
  )
}

pub fn search_case_insensitive_test() {
  let poem =
    "I'm nobody! Who are you?
Are you nobody, too?
Then there's a pair of us - don't tell!
They'd banish us, you know.

How dreary to be somebody!
How public, like a frog
To tell your name the livelong day
To an admiring bog!"

  should.equal(
    search.search_case_insensitive(poem, "the"),
    [
      "Then there's a pair of us - don't tell!", "They'd banish us, you know.",
      "To tell your name the livelong day",
    ],
  )
}
