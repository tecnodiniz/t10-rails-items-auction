require 'rails_helper'

describe 'Administrador adiciona item ao lot' do
    it 'com sucesso' do 
        user = User.create!(email:'eduardo@leilaodogalpao.com.br', password: 'password', cpf:'44047449865', admin: true)
        c_1 = Category.create!(description: 'Eletro Doméstico')
        c_2 = Category.create!(description: 'Roupas')

        Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
                depth:20, category:c_1)
                
        Item.create!(name:'Som Surrond 7.2', url_img:'',weight:3000,height:70,width:30, 
                    depth:5, category:c_1)

        login_as(user)

        visit root_path
        click_on "Lotes para leilão"


    end
end