require 'rails_helper'

feature 'Usuário vê detalhes de um lote disponível' do
  context 'com sucesso' do
    scenario 'lotes em andamento' do
      user = User.create!(email: 'user@gmail.com', cpf: '66978657689', password: 'password')
      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
      lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                        min_value: '400', dif_value: '400', administrator: admin, status: :aproved)

      category = ProdCategory.create!(description: 'Doméstico')
      category2 = ProdCategory.create!(description: 'Eletrônico')
      logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
      product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                                prod_category: category, logo:, status: :selected)
      product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                                 prod_category: category2, logo:, status: :selected)

      LotItem.create!(lot:, product:)
      LotItem.create!(lot:, product: product2)

      login_as user

      visit root_path

      click_on lot.code

      expect(current_path).to eq lot_path(lot)
      expect(page).to have_content 'Lote BAH295403'
      expect(page).to have_content "Início: #{I18n.l(Time.zone.today.to_date)}"
      expect(page).to have_content "Fim: #{I18n.l(5.days.from_now.to_date)}"
      expect(page).to have_content 'Lance mínimo: R$400.0'
      expect(page).to have_content 'Diferença de lance: R$400.0'
      expect(page).to have_content 'Dar lance'
      expect(page).not_to have_content 'Editar'
      expect(page).not_to have_content 'Adicionar itens'
    end

    scenario 'lotes futuros' do
      user = User.create!(email: 'user@gmail.com', cpf: '66978657689', password: 'password')
      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
      lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                        min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      lot2 = Lot.create!(code: 'ZAR295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                         min_value: '400', dif_value: '400', administrator: admin, status: :aproved)

      category = ProdCategory.create!(description: 'Doméstico')
      category2 = ProdCategory.create!(description: 'Eletrônico')
      logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
      product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                                prod_category: category, logo:, status: :selected)
      product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                                 prod_category: category2, logo:, status: :selected)

      LotItem.create!(lot:, product:)
      LotItem.create!(lot: lot2, product: product2)

      login_as user

      visit root_path

      click_on lot2.code

      expect(current_path).to eq lot_path(lot2)
      expect(page).to have_content 'Lote ZAR295403'
      expect(page).to have_content "Início: #{I18n.l(lot2.start_date)}"
      expect(page).to have_content "Fim: #{I18n.l(lot2.limit_date)}"
      expect(page).to have_content 'Lance mínimo: R$400.0'
      expect(page).to have_content 'Diferença de lance: R$400.0'
      expect(page).not_to have_content 'Dar lance'
      expect(page).not_to have_content 'Editar'
      expect(page).not_to have_content 'Adicionar itens'
    end
  end
end
