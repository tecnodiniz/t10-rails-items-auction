require 'rails_helper'

feature 'Administrador cadastra uma categoria' do
  scenario 'com sucesso' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')

    login_as admin, scope: :administrator

    visit root_path

    click_on 'Categorias'
    click_on 'Nova categoria'

    fill_in 'Categoria',	with: 'Eletrônica'
    click_on 'Salvar'

    expect(page).to have_content 'Categoria cadastrada com sucesso'
    expect(page).to have_content 'Eletrônica'
  end
  scenario 'e falha por categoria estar em branco' do
    admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
    login_as admin, scope: :administrator

    visit root_path

    click_on 'Categorias'
    click_on 'Nova categoria'

    fill_in 'Categoria',	with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Categoria não cadastrada'
    expect(page).to have_content 'Categoria não pode ficar em branco'
  end
end
