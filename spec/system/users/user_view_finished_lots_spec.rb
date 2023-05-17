require 'rails_helper'

describe 'usuário acessa página principal' do
    it 'e vê todos os leilões em que ele venceu' do 
        user = User.create!(email:'diniz480@gmail.com', password: '@@l0ck3d0u7@@',cpf:'44047449865',admin:true)
        user_2 = User.create!(email:'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@',cpf:'61857677676',admin:true)

        regular_user = User.create!(email:'eduardohdp@hotmail.com', password: '@@l0ck3d0u7@@',cpf:'08306516087',admin:false)

        c_1 = Category.create!(description: 'Eletro Doméstico')
        c_2 = Category.create!(description: 'Roupas')

        item_1 = Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20, category:c_1)
                
        item_2 = Item.create!(name:'Som Surrond 7.2', url_img:'',weight:3000,height:70,width:30, 
                    depth:5, category:c_1)

        lot = Lot.create!(code: 'GAD459812', start_date:'11-05-2023',limit_date:'12-05-2023',min_value:1000.00,
            dif_value:500.00,aproved:true, user:user)

        Lot.create!(code: 'GAD459830', start_date:'04-04-2022',limit_date:'04-05-2022',min_value:1000.00,
            dif_value:500.00,aproved:true, user:user)

        LotItem.create!(lot_id: lot.id, item_id: item_1.id)
        LotItem.create!(lot_id: lot.id, item_id: item_2.id)

        Aproved.create!(lot_id:lot.id, user_id:user_2.id, date_aproved: Date.today)

       
        Bid.create(lot_id:lot.id, user_id:user.id, value: 12000)
        Bid.create(lot_id:lot.id, user_id:user_2.id, value: 13000)
        Bid.create(lot_id:lot.id, user_id:regular_user.id, value: 15000)

        winner = Bid.where(lot_id:lot.id).last

        Finalized.create!(lot_id: lot.id)
        Winner.create!(lot_id: lot.id, user_id:winner.user_id)

        login_as(regular_user)

        visit root_path
        click_on 'Lotes para leilão'
        click_on 'Lotes vencidos'

        expect(page).to have_content 'Vencedores'
        expect(page).to have_content 'GAD459812'
        expect(page).to have_content 'eduardohdp@hotmail.com'
    
    end
end