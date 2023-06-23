# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
product = Product.create!(
  name: "商品名1",
  price: 1000,
  description: "美味しいケーキです",
)

product = Product.create!(
  name: "商品名2",
  price: 2000,
  description: "美味しいケーキです",
)

product = Product.create!(
  name: "商品名3",
  price: 3000,
  description: "美味しいケーキです",
)

product = Product.create!(
  name: "商品名4",
  price: 4000,
  description: "美味しいケーキです",
)