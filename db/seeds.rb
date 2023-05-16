# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(email:'diniz480@gmail.com', password: '@@l0ck3d0u7@@',cpf:'44047449865',admin:true)
user_2 = User.create!(email:'eduardo@leilaodogalpao.com.br', password: '@@l0ck3d0u7@@',cpf:'61882855345',admin:true)
regular_user = User.create!(email:'eduardo@gmail.com', password: '@@l0ck3d0u7@@',cpf:'83733911261',admin:false)

c = Category.create!(description: 'Eletro Doméstico')
c_2 = Category.create!(description: 'Informática')

item_1 = Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20,code:'ABXPA0-EJN22-IEDCVHX', category:c)
                
item_2 = Item.create!(name:'Mouse', url_img:'',weight:200,height:10,width:10, 
    depth:20, category:c_2)

                    
Item.create!(name:'Teclado', url_img:'',weight:200,height:10,width:10, 
    depth:20, category:c_2)

                    
Item.create!(name:'Gabinete', url_img:'',weight:200,height:10,width:10, 
    depth:20, category:c_2)

                    
Item.create!(name:'Fonte de alimentação', url_img:'',weight:200,height:10,width:10, 
    depth:20, category:c_2)


Item.create!(name:'Monitor', url_img:'',weight:200,height:10,width:10, 
    depth:20, category:c_2)

                    
Item.create!(name:'Cadeira Gamer', url_img:'',weight:200,height:10,width:10, 
    depth:20, category:c_2)

lot = Lot.create!(code: 'GAD459812', start_date:'11-04-2023',limit_date:'11-05-2023',min_value:1000,
    dif_value:500.00, aproved:true, user:user)

Lot.create!(code: 'BAT128290', start_date:'10-05-2022',limit_date:'11-06-2022',min_value:1000,
    dif_value:500.00, user:user)

Lot.create!(code: 'CAD128290', start_date:'10-06-2023',limit_date:'11-06-2023',min_value:1000,
        dif_value:500.00, user:user)

Lot.create!(code: 'CEA128290', start_date:'10-07-2023',limit_date:'13-07-2023',min_value:1000,
        dif_value:500.00, user:user)

LotItem.create!(lot_id: lot.id, item_id: item_1.id)
LotItem.create!(lot_id: lot.id, item_id: item_2.id)

Aproved.create!(lot_id:lot.id, user_id:user_2.id, date_aproved: Date.today)

Bid.create!(lot_id:lot.id, user_id:regular_user.id, value: 10000)
Bid.create!(lot_id:lot.id, user_id:user.id, value: 12000)
Bid.create!(lot_id:lot.id, user_id:user_2.id, value: 13000)