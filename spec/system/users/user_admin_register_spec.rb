require 'rails_helper'

describe 'A partir da tela inicial' do
    it 'usuários administrador vê link de cadastro de novos usuários' do 
        user = User.create!(email:'eduardo@leilaodogalpao.com.br', password: 'password', cpf:'44047449865', admin: true)
        login_as(user)

        visit root_path

    end
    it 'usuario cadastra um administrador' do 
        user = User.create!(email:'eduardo@leilaodogalpao.com.br', password: 'password', cpf:'44047449865', admin: true)
        login_as(user)

        visit root_path

        click_on 'Gerenciar usuários'
        click_on 'Cadastrar admin'


        element = find(:css, "input[id$='email-input']")

        fill_in element[:name],	with: "diniz" 
        fill_in "Senha",	with: "password@leilaodogalpao"
        fill_in "Confirme sua senha",	with: "password@leilaodogalpao"
        fill_in "CPF", with: "23667678703"

        click_on "Criar Usuário"
        new_user = User.last

        expect(page).to have_content 'User was successfully created.'
        expect(new_user.admin).to eq true
    end 

    it 'usuário cadastra um usuário comum' do 
        user = User.create!(email:'eduardo@leilaodogalpao.com.br', password: 'password', cpf:'44047449865', admin: true)
        login_as(user)

        visit root_path

        click_on 'Gerenciar usuários'
        click_on 'Cadastrar usuário'

        fill_in "E-mail",	with: "diniz@gmail.com.br" 
        fill_in "Senha",	with: "password@leilaodogalpao"
        fill_in "Confirme sua senha",	with: "password@leilaodogalpao"
        fill_in "CPF", with: "23667678703"

        click_on 'Criar Usuário'
 

        
        new_user = User.last

        expect(page).to have_content 'User was successfully created.'
        expect(new_user.admin).to eq false
    end 


end