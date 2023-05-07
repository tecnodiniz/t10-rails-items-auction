# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(email:'diniz480@gmail.com', password: '@@l0ck3d0u7@@',cpf:'44047449865',admin:true)
c = Category.create!(description: 'Eletro Doméstico')
Category.create!(description: 'Roupas')

Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20,code:'ABXPA0-EJN22-IEDCVHX', category:c)