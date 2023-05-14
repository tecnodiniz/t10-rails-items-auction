require 'rails_helper'

describe 'Usuário visita página de itens' do 
    it 'e vê link para criar novos itens caso seja administrador' do 
        user = User.create!(email:'diniz480@gmail.com', password: '@@l0ck3d0u7@@',cpf:'44047449865',admin:true)
        user_2 = User.create!(email:'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@',cpf:'61857677676',admin:true)

        regular_user = User.create!(email:'eduardohdp@hotmail.com', password: '@@l0ck3d0u7@@',cpf:'08306516087',admin:false)

        c_1 = Category.create!(description: 'Eletrônico')
        c_2 = Category.create!(description: 'Roupas')

        item_1 = Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20, category:c_1)
                
        item_2 = Item.create!(name:'Som Surrond 7.2', url_img:'',weight:3000,height:70,width:30, 
                    depth:5, category:c_1)

        lot = Lot.create!(code: 'GAD459812', start_date: 5.days.from_now ,limit_date: 6.days.from_now ,min_value:1000.00,
            dif_value:500.00,aproved:true, user:user)

        LotItem.create!(lot_id: lot.id, item_id: item_1.id)
        LotItem.create!(lot_id: lot.id, item_id: item_2.id)

        Aproved.create!(lot_id:lot.id, user_id:user_2.id, date_aproved: '11-04-2023')
        
        login_as(regular_user)

        visit root_path

        click_on 'GAD459812'
        click_on 'Televisão Samsung'

        expect(page).to have_content 'Produto: Televisão Samsung'
        expect(page).to have_content 'Peso: 8000g'
        expect(page).to have_content 'Altura: 70cm'
        expect(page).to have_content 'Largura: 90cm'
        expect(page).to have_content 'Profundidade: 20cm'
        expect(page).to have_content 'Categoria: Eletrônico'



    end

end