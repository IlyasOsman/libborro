# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Book.destroy_all

books = [
  { title: "The Pragmatic Programmer", author: "Andrew Hunt", isbn: "978-0201616224" },
  { title: "Clean Code", author: "Robert C. Martin", isbn: "978-0132350884" },
  { title: "Eloquent Ruby", author: "Russ Olsen", isbn: "978-0321584106" },
  { title: "You Don't Know JS", author: "Kyle Simpson", isbn: "978-1491904244" },
  { title: "Design Patterns", author: "Erich Gamma", isbn: "978-0201633610" },
  { title: "Refactoring", author: "Martin Fowler", isbn: "978-0201485677" },
  { title: "The Clean Coder", author: "Robert C. Martin", isbn: "978-0137081073" },
  { title: "Introduction to Algorithms", author: "Thomas H. Cormen", isbn: "978-0262033848" },
  { title: "The Mythical Man-Month", author: "Frederick P. Brooks Jr.", isbn: "978-0201835953" },
  { title: "Code Complete", author: "Steve McConnell", isbn: "978-0735619678" },
  { title: "Algorithms Unlocked", author: "Thomas H. Cormen", isbn: "978-0262518802" },
  { title: "Deep Learning", author: "Ian Goodfellow", isbn: "978-0262035613" },
  { title: "Artificial Intelligence", author: "Stuart Russell", isbn: "978-0136042594" },
  { title: "Learning Python", author: "Mark Lutz", isbn: "978-1449355739" },
  { title: "Python Crash Course", author: "Eric Matthes", isbn: "978-1593276034" },
  { title: "The Art of Computer Programming", author: "Donald Knuth", isbn: "978-0201896831" },
  { title: "Programming Pearls", author: "Jon Bentley", isbn: "978-0201657883" },
  { title: "Structure and Interpretation of Computer Programs", author: "Harold Abelson", isbn: "978-0262510875" },
  { title: "Compilers: Principles, Techniques, and Tools", author: "Alfred Aho", isbn: "978-0321486813" },
  { title: "Head First Design Patterns", author: "Eric Freeman", isbn: "978-0596007126" }
]

books.each do |book|
  Book.create!(
    title: book[:title],
    author: book[:author],
    isbn: book[:isbn]
  )
end

puts "✅ Seeded #{Book.count} books"
