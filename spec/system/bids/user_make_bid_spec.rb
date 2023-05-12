require 'rails_helper'

describe 'Usuário faz um lance' do
    it 'com sucesso' do

        user = User.create!(email:'diniz480@gmail.com', password: '@@l0ck3d0u7@@',cpf:'44047449865',admin:true)
        user_2 = User.create!(email:'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@',cpf:'61857677676',admin:true)

        regular_user = User.create!(email:'eduardohdp@hotmail.com', password: '@@l0ck3d0u7@@',cpf:'08306516087',admin:false)

        c_1 = Category.create!(description: 'Eletro Doméstico')
        c_2 = Category.create!(description: 'Roupas')

        item_1 = Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20, category:c_1)
                
        item_2 = Item.create!(name:'Som Surrond 7.2', url_img:'',weight:3000,height:70,width:30, 
                    depth:5, category:c_1)

        lot = Lot.create!(code: 'GAD459812', start_date:'11-05-2023',limit_date:'11-06-2023',min_value:1000.00,
            dif_value:500.00,aproved:true, user:user)

        LotItem.create!(lot_id: lot.id, item_id: item_1.id)
        LotItem.create!(lot_id: lot.id, item_id: item_2.id)

        Aproved.create!(lot_id:lot.id, user_id:user_2.id, date_aproved: Date.today)
        
        login_as(regular_user)

        visit root_path

        click_on 'GAD459812'
        click_on 'Dar lance'

        fill_in 'Lance', with: 1500
        click_on 'Enviar' 

        expect(page).to have_content 'Lance efetuado com sucesso'

    end
    it 'e vê lance efetuado nos detalhes do lote' do 
        user = User.create!(email:'diniz480@gmail.com', password: '@@l0ck3d0u7@@',cpf:'44047449865',admin:true)
        user_2 = User.create!(email:'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@',cpf:'61857677676',admin:true)

        regular_user = User.create!(email:'eduardohdp@hotmail.com', password: '@@l0ck3d0u7@@',cpf:'08306516087',admin:false)

        c_1 = Category.create!(description: 'Eletro Doméstico')
        c_2 = Category.create!(description: 'Roupas')

        item_1 = Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20, category:c_1)
                
        item_2 = Item.create!(name:'Som Surrond 7.2', url_img:'',weight:3000,height:70,width:30, 
                    depth:5, category:c_1)

        lot = Lot.create!(code: 'GAD459812', start_date:'11-05-2023',limit_date:'11-06-2023',min_value:1000.00,
            dif_value:500.00,aproved:true, user:user)

        LotItem.create!(lot_id: lot.id, item_id: item_1.id)
        LotItem.create!(lot_id: lot.id, item_id: item_2.id)

        Aproved.create!(lot_id:lot.id, user_id:user_2.id, date_aproved: Date.today)
        
        login_as(regular_user)

        visit root_path

        click_on 'GAD459812'
        click_on 'Dar lance'

        fill_in 'Lance', with: 1500
        click_on 'Enviar' 

        expect(page).to have_content 'Seu lance: 1500'

    end

    it 'e falha a dar lance menor que o valor mínimo' do
        
        user = User.create!(email:'diniz480@gmail.com', password: '@@l0ck3d0u7@@',cpf:'44047449865',admin:true)
        user_2 = User.create!(email:'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@',cpf:'61857677676',admin:true)

        regular_user = User.create!(email:'eduardohdp@hotmail.com', password: '@@l0ck3d0u7@@',cpf:'08306516087',admin:false)

        c_1 = Category.create!(description: 'Eletro Doméstico')
        c_2 = Category.create!(description: 'Roupas')

        item_1 = Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20, category:c_1)
                
        item_2 = Item.create!(name:'Som Surrond 7.2', url_img:'',weight:3000,height:70,width:30, 
                    depth:5, category:c_1)

        lot = Lot.create!(code: 'GAD459812', start_date:'11-05-2023',limit_date:'11-06-2023',min_value:1000.00,
            dif_value:500.00,aproved:true, user:user)

        LotItem.create!(lot_id: lot.id, item_id: item_1.id)
        LotItem.create!(lot_id: lot.id, item_id: item_2.id)

        Aproved.create!(lot_id:lot.id, user_id:user_2.id, date_aproved: Date.today)
        
        login_as(regular_user)

        visit root_path

        click_on 'GAD459812'
        click_on 'Dar lance'

        fill_in 'Lance', with: 900
        click_on 'Enviar' 

        expect(page).to have_content 'O lance deve ser maior ou igual ao valor mínimo'
    end

    it 'e vê lance anterior ' do 
        user = User.create!(email:'diniz480@gmail.com', password: '@@l0ck3d0u7@@',cpf:'44047449865',admin:true)
        user_2 = User.create!(email:'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@',cpf:'61857677676',admin:true)

        regular_user = User.create!(email:'eduardohdp@hotmail.com', password: '@@l0ck3d0u7@@',cpf:'08306516087',admin:false)

        c_1 = Category.create!(description: 'Eletro Doméstico')
        c_2 = Category.create!(description: 'Roupas')

        item_1 = Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20, category:c_1)
                
        item_2 = Item.create!(name:'Som Surrond 7.2', url_img:'',weight:3000,height:70,width:30, 
                    depth:5, category:c_1)

        lot = Lot.create!(code: 'GAD459812', start_date:'11-05-2023',limit_date:'11-06-2023',min_value:1000.00,
            dif_value:500.00,aproved:true, user:user)

        LotItem.create!(lot_id: lot.id, item_id: item_1.id)
        LotItem.create!(lot_id: lot.id, item_id: item_2.id)

        Aproved.create!(lot_id:lot.id, user_id:user_2.id, date_aproved: Date.today)
        Bid.create!(lot_id:lot.id, user_id:user_2.id, value: 1000)
        
        login_as(regular_user)

        visit root_path

        click_on 'GAD459812'
        click_on 'Dar lance'

        fill_in 'Lance', with: 1000
        click_on 'Enviar' 

        expect(page).to have_content 'Lance atual: 1000'
    end
end