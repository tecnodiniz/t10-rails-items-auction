require 'rails_helper' 

describe "Usuário remove item do lote" do
    it 'com sucesso' do
        user = User.create!(email:'eduardo@leilaodogalpao.com.br', password: 'password', cpf:'44047449865', admin: true)
        c_1 = Category.create!(description: 'Eletro Doméstico')
        c_2 = Category.create!(description: 'Roupas')

        Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20, category:c_1)
                
        Item.create!(name:'Som Surrond 7.2', url_img:'',weight:3000,height:70,width:30, 
                    depth:5, category:c_1)

        Lot.create!(code: 'GAD459812', start_date:'10-04-2023',limit_date:'04-05-2023',min_value:1000.00,
            dif_value:500.00,aproved:false, user:user)

        LotItem.create!(lot_id:1,item_id:1)
        LotItem.create!(lot_id:1,item_id:2)

        login_as(user)

        visit root_path

        click_on "Lotes para leilão"
        click_on "Visualizar todos os lotes"
        click_on "GAD459812"

        within('table') do 
            xpath = "//*[@id='1'] "
            button = find(:xpath,xpath)
            button.click
        end

        expect(page).to have_content 'Item removido'
        expect(page).not_to have_content 'Televisão Samsung'

    end

    it 'e vê item disponível para adicionar ao lote' do 
        user = User.create!(email:'eduardo@leilaodogalpao.com.br', password: 'password', cpf:'44047449865', admin: true)
        c_1 = Category.create!(description: 'Eletro Doméstico')
        c_2 = Category.create!(description: 'Roupas')

        Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20,selected:true, category:c_1)
                
        Item.create!(name:'Som Surrond 7.2', url_img:'',weight:3000,height:70,width:30, 
                    depth:5,selected:true, category:c_1)

        Lot.create!(code: 'GAD459812', start_date:'04-04-2023',limit_date:'04-05-2023',min_value:1000.00,
            dif_value:500.00,aproved:false, user:user)

        LotItem.create!(lot_id:1,item_id:1)
        LotItem.create!(lot_id:1,item_id:2)

        login_as(user)

        visit root_path

        click_on "Lotes para leilão"
        click_on "Visualizar todos os lotes"
        click_on "GAD459812"

        within('table') do 
            xpath = "//*[@id='1'] "
            button = find(:xpath,xpath)
            button.click
        end

        visit lots_all_path

        click_on "Adicionar item"

        expect(page).to have_select 'Produto', with_options: ['Televisão Samsung']
       

    end

    it 'e falha, pois o lote já foi aprovado' do 
        user = User.create!(email:'diniz480@gmail.com', password: '@@l0ck3d0u7@@',cpf:'44047449865',admin:true)
        user_2 = User.create!(email:'eduardo@leilãoestoque.com.br', password: '@@l0ck3d0u7@@',cpf:'61857677676',admin:true)

        c = Category.create!(description: 'Eletro Doméstico')
        c_2 = Category.create!(description: 'Informática')

        Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                        depth:20,code:'ABXPA0-EJN22-IEDCVHX', category:c)
                        
        Item.create!(name:'Mouse', url_img:'',weight:200,height:10,width:10, 
            depth:20, category:c_2)

        Lot.create!(code: 'GAD459812', start_date:'04-04-2022',limit_date:'04-05-2022',min_value:1000.00,
            dif_value:500.00, user:user)

        Lot.create!(code: 'BAT412820', start_date:'04-04-2022',limit_date:'04-05-2022',min_value:1000.00,
            dif_value:500.00, user:user)


        LotItem.create!(lot_id:1,item_id:1)
        LotItem.create!(lot_id:1,item_id:2)

        login_as(user_2)

        visit root_path 

     
        click_on "Lotes para leilão"
        click_on "Visualizar todos os lotes"

        within('table') do 
            xpath = "//*[@id='1'] "
            button = find(:xpath,xpath)
            button.click
        end

        click_on "GAD459812"

        within('table') do 
            xpath = "//*[@id='1'] "
            button = find(:xpath,xpath)
            button.click
        end

        expect(page).to have_content 'Não é possível remover itens'  
        expect(page).to have_content 'Televisão Samsung'
        
    end
    
end
