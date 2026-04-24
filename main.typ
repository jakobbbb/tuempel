#import "@mae/tümpel:0.0.1": *

#set document(
  title: "Hello, Typst!",
  author: ("Jane Doe",)
)
#show: tümpel.with(
  institute: "University of Ipsum",
  email: ("jane.doe@example.com",)
)

= Lorem Ipsum

lipsum(10)

#thm("Hello")[
  "Hello" is a nice greeting.
]

#defn(ref: "pi")[$pi$][
  A number.
]

Please consult @Theorem_Hello and @Definition_pi!
