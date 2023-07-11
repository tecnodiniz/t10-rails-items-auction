require 'rails_helper'

describe 'Usuário visita página de lotes' do
  context 'como administrador' do
    it 'e vê todos os lotes cadastrados' do
      user = User.create!(email: 'eduardo@leilãoestoque.com.br', password: 'eduardo123', cpf: '44047449865',
                          admin: true)

      Lot.create!(code: 'GAD459812', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                  dif_value: 500.00, aproved: false, user:)

      login_as(user)

      visit root_path
      click_on 'Lotes para leilão'
      click_on 'Visualizar todos os lotes'

      expect(page).to have_content 'GAD459812'
      expect(page).to have_content 'aguardando aprovação'
      expect(page).to have_content 'eduardo@leilãoestoque.com.br'
    end
  end

  context 'como usuário comum' do
    it 'e não vê link para acessar todos os lotes' do
      user = User.create!(email: 'eduardo@leilãoestoque.com.br', password: 'eduardo123', cpf: '44047449865',
                          admin: false)

      Lot.create!(code: 'GAD459812', start_date: '04-04-2022', limit_date: '04-05-2022', min_value: 1000.00,
                  dif_value: 500.00, aproved: false, user:)

      login_as(user)

      visit root_path
      click_on 'Lotes para leilão'

      expect(page).not_to have_content 'Visualizar todos os lotes'
    end
  end
end
