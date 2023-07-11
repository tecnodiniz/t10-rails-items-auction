require 'rails_helper'

describe 'Usuário cadastra novo lote' do
  it 'com sucesso' do
    user = User.create!(email: 'eduardo@leilaodogalpao.com.br', password: 'password', cpf: '44047449865', admin: true)
    login_as(user)

    visit root_path

    click_on 'Lotes para leilão'
    click_on 'Visualizar todos os lotes'
    click_on 'Novo lote'

    fill_in 'Código',	with: 'BAH295403'
    fill_in 'Início',	with: Time.zone.today
    fill_in 'Limite',	with: 5.days.from_now
    fill_in 'Valor mínimo',	with: '4000'
    fill_in 'Diferença de lance',	with: '500'

    click_on 'Criar lote'

    expect(page).to have_content 'Lote criado com sucesso'
    expect(current_path).to eq lots_all_path
  end
end
