require 'rails_helper'

describe 'Usuário autenticado cadastra item para leilão' do 
    it 'a partir da tela inicial' do 
        user = User.create!(email:'eduardo@leilaodogalpao.com.br', password: 'password', cpf:'44047449865', admin: true)
        login_as(user)

        category = Category.create!(description: 'Eletro Doméstico')
        # item =  Item.create!(name:'Televisão Samsung', url_img:'',weight:8000,height:70,width:90, 
        #         depth:20,code:'ABXPA0-EJN22-IEDCVHX', category:category)

        visit root_path

        click_on 'Itens'

        click_on 'Cadastrar item para leilão'

        fill_in "Nome", with: 'Televisão Samsung'
        fill_in "Url da imagem", with: ''
        fill_in "Peso", with: '8000'
        fill_in "Altura", with: '70'
        fill_in "Largura", with: '90'
        fill_in "Profundidade", with: '20'
        fill_in "Peso", with: '8000'
        select category.description, from: "Categoria"

        click_on "Enviar"

        item = Item.last

        expect(page).to have_content 'Item cadastrado com sucesso'
        expect(page).to have_content "#{item.code}"
        expect(page).to have_content "Televisão Samsung"

         
    end

end