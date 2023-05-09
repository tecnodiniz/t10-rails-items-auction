# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create!(email:'diniz480@gmail.com', password: '@@l0ck3d0u7@@',cpf:'44047449865',admin:true)

c = Category.create!(description: 'Eletro Doméstico')
c_2 = Category.create!(description: 'Informática')

Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20,code:'ABXPA0-EJN22-IEDCVHX', category:c)
                
Item.create!(name:'Mouse', url_img:'',weight:200,height:10,width:10, 
    depth:20, category:c_2)

Lot.create!(code: 'GAD-459812', start_date:'04-04-2022',limit_date:'04-05-2022',min_value:1000.00,
    dif_value:500.00,aproved:true, user:user)

Lot.create!(code: 'BAT-412820', start_date:'04-04-2022',limit_date:'04-05-2022',min_value:1000.00,
    dif_value:500.00, user:user)