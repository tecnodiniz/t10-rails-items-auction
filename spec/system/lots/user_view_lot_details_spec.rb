require 'rails_helper'

describe 'Usuário vê detalhes do lote' do 
    it 'com sucesso' do 
        user = User.create!(email:'eduardo@leilãoestoque.com.br', password: 'eduardo123',cpf:'44047449865', admin: false)

        c_1 = Category.create!(description: 'Eletro Doméstico')
        c_2 = Category.create!(description: 'Roupas')
        c_3 = Category.create!(description: 'Games')

        Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20, category:c_1)
                
        Item.create!(name:'Som Surrond 7.2', url_img:'',weight:3000,height:70,width:30, 
                    depth:5, category:c_1)

        Item.create!(name:'Playstation 2', url_img:'',weight:500,height:70,width:30, 
            depth:5, category:c_3)

        Lot.create!(code: 'GAD459812', start_date:'10-05-2023',limit_date:'04-06-2023',min_value:1000.00,
                        dif_value:500.00, aproved:true, user:user)

        Lot.create!(code: 'JAE459812', start_date:'10-05-2023',limit_date:'10-06-2023',min_value:1000.00,
            dif_value:500.00, aproved:true, user:user)

        LotItem.create!(lot_id:1, item_id: 1)
        LotItem.create!(lot_id:1, item_id: 2)
        LotItem.create!(lot_id:1, item_id: 3)


        visit root_path
        click_on 'GAD459812'

        expect(page).to have_content 'GAD459812'
        expect(page).to have_content 'Inicio: 10/05/2023'
        expect(page).to have_content 'Fim: 04/06/2023'
        expect(page).to have_content 'Lance mínimo: R$1000'
        expect(page).to have_content 'Televisão Samsung'
        expect(page).to have_content 'Playstation 2'
        expect(page).to have_content 'Som Surrond 7.2'

    end  
end