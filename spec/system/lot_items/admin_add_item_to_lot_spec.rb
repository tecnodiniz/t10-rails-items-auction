require 'rails_helper'

describe 'Administrador adiciona item ao lot' do
  it 'com sucesso' do
    user = User.create!(email: 'eduardo@leilaodogalpao.com.br', password: 'password', cpf: '44047449865', admin: true)
    c_1 = Category.create!(description: 'Eletro Doméstico')
    c_2 = Category.create!(description: 'Roupas')

    Item.create!(name: 'Televisão Samsung', url_img: '', weight: 8000, height: 70, width: 90,
                 depth: 20, category: c_1)

    Item.create!(name: 'Som Surrond 7.2', url_img: '', weight: 3000, height: 70, width: 30,
                 depth: 5, category: c_1)

    Lot.create!(code: 'GAD459812', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                dif_value: 500.00, aproved: false, user:)

    login_as(user)

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Visualizar todos os lotes'
    click_on 'Adicionar item'

    within('#form-content') do
      select 'Som Surrond 7', from: 'Produto'
      click_on 'Salvar'
    end

    expect(page).to have_content 'Item adicionado ao lote: GAD459812'
  end
end
