require 'rails_helper'

feature 'Usuário faz um lance' do
  context 'com sucesso' do
    scenario 'primeiro lance ao lote' do
      user = User.create!(email: 'user@gmail.com', cpf: '66978657689', password: 'password')
      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
      lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                        min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      lot2 = Lot.create!(code: 'ZAR295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                         min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      Lot.create!(code: 'HAZ295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                  min_value: '400', dif_value: '400', administrator: admin, status: :awaiting)

      category = ProdCategory.create!(description: 'Doméstico')
      category2 = ProdCategory.create!(description: 'Eletrônico')
      logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
      product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                                prod_category: category, logo:, status: :selected)
      product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                                 prod_category: category2, logo:, status: :selected)

      LotItem.create!(lot:, product:)
      LotItem.create!(lot: lot2, product: product2)

      login_as user, scope: :user

      visit root_path

      click_on lot.code

      click_on 'Dar lance'

      fill_in 'Valor',	with: '400'
      click_on 'Criar Lance'

      expect(page).to have_content 'Lance realizado com sucesso'
      expect(page).to have_content 'Seu lance: R$400'
      expect(page).to have_content 'Último lance: R$400'
    end

    scenario 'em um lote com um lance existente' do
      user = User.create!(email: 'user@gmail.com', cpf: '66978657689', password: 'password')
      user2 = User.create!(email: 'user2@gmail.com', cpf: '51027834833', password: 'password')

      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
      lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                        min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      lot2 = Lot.create!(code: 'ZAR295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                         min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      Lot.create!(code: 'HAZ295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                  min_value: '400', dif_value: '400', administrator: admin, status: :awaiting)

      category = ProdCategory.create!(description: 'Doméstico')
      category2 = ProdCategory.create!(description: 'Eletrônico')
      logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
      product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                                prod_category: category, logo:, status: :selected)
      product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                                 prod_category: category2, logo:, status: :selected)

      LotItem.create!(lot:, product:)
      LotItem.create!(lot: lot2, product: product2)

      Bid.create!(lot:, user: user2, value: 400)
      Bid.create!(lot:, user: user2, value: 800)

      login_as user, scope: :user

      visit root_path

      click_on lot.code

      click_on 'Dar lance'

      fill_in 'Valor',	with: '1200'
      click_on 'Criar Lance'

      expect(page).to have_content 'Lance realizado com sucesso'
      expect(page).to have_content 'Seu lance: R$1200'
      expect(page).to have_content 'Último lance: R$1200'
    end
  end

  context 'e falha' do
    scenario 'com lance menor que o valor mínimo' do
      user = User.create!(email: 'user@gmail.com', cpf: '66978657689', password: 'password')
      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
      lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                        min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      lot2 = Lot.create!(code: 'ZAR295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                         min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      Lot.create!(code: 'HAZ295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                  min_value: '400', dif_value: '400', administrator: admin, status: :awaiting)

      category = ProdCategory.create!(description: 'Doméstico')
      category2 = ProdCategory.create!(description: 'Eletrônico')
      logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
      product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                                prod_category: category, logo:, status: :selected)
      product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                                 prod_category: category2, logo:, status: :selected)

      LotItem.create!(lot:, product:)
      LotItem.create!(lot: lot2, product: product2)

      login_as user, scope: :user

      visit root_path

      click_on lot.code

      click_on 'Dar lance'

      fill_in 'Valor',	with: '300'
      click_on 'Criar Lance'

      expect(page).to have_content 'Não foi possível fazer o lance'
      expect(page).to have_content 'O valor mínimo para esse lote é R$400'
    end

    scenario 'com lance que a diferença mínima' do
      user = User.create!(email: 'user@gmail.com', cpf: '66978657689', password: 'password')
      user2 = User.create!(email: 'user2@gmail.com', cpf: '51027834833', password: 'password')

      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
      lot = Lot.create!(code: 'BAH295403', start_date: Time.zone.today, limit_date: 5.days.from_now,
                        min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      lot2 = Lot.create!(code: 'ZAR295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                         min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      Lot.create!(code: 'HAZ295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                  min_value: '400', dif_value: '400', administrator: admin, status: :awaiting)

      category = ProdCategory.create!(description: 'Doméstico')
      category2 = ProdCategory.create!(description: 'Eletrônico')
      logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
      product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                                prod_category: category, logo:, status: :selected)
      product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                                 prod_category: category2, logo:, status: :selected)

      LotItem.create!(lot:, product:)
      LotItem.create!(lot: lot2, product: product2)

      Bid.create!(lot:, user: user2, value: 400)
      Bid.create!(lot:, user: user2, value: 800)

      login_as user, scope: :user

      visit root_path

      click_on lot.code

      click_on 'Dar lance'

      fill_in 'Valor',	with: '500'
      click_on 'Criar Lance'

      expect(page).to have_content 'Não foi possível fazer o lance'
      expect(page).to have_content 'A diferença de valor para esse lance é de R$400'
    end

    scenario 'em um lote com data limite alcançada' do
      user = User.create!(email: 'user@gmail.com', cpf: '66978657689', password: 'password')
      user2 = User.create!(email: 'user2@gmail.com', cpf: '51027834833', password: 'password')

      admin = Administrator.create!(email: 'admin@leilaodogalpao.com.br', cpf: '44047449865', password: 'password')
      lot = Lot.new(code: 'BAH295403', start_date: '20/06/2023', limit_date: '10/07/2023',
                    min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      lot.save(validate: false)

      lot2 = Lot.create!(code: 'ZAR295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                         min_value: '400', dif_value: '400', administrator: admin, status: :aproved)
      Lot.create!(code: 'HAZ295403', start_date: 2.days.from_now, limit_date: 5.days.from_now,
                  min_value: '400', dif_value: '400', administrator: admin, status: :awaiting)

      category = ProdCategory.create!(description: 'Doméstico')
      category2 = ProdCategory.create!(description: 'Eletrônico')
      logo = fixture_file_upload('spec/support/images/logo.png', 'image/png')
      product = Product.create!(name: 'TV 32 Samsung', width: '30', height: '20', weight: '15', depth: '10',
                                prod_category: category, logo:, status: :selected)
      product2 = Product.create!(name: 'SOUNDBAR SONY', width: '30', height: '20', weight: '15', depth: '10',
                                 prod_category: category2, logo:, status: :selected)

      LotItem.create!(lot:, product:)
      LotItem.create!(lot: lot2, product: product2)

      Bid.create!(lot:, user: user2, value: 400)
      Bid.create!(lot:, user: user2, value: 800)

      login_as user, scope: :user

      visit root_path

      click_on lot.code

      click_on 'Dar lance'

      expect(page).to have_content 'Lances encerrados'
    end
  end
end
