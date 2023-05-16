require 'rails_helper'

describe 'Usuário acessa a página de lotes' do 
    it 'e vê somente lotes aprovados' do 
        user = User.create!(email:'eduardo@leilãoestoque.com.br', password: 'eduardo123',cpf:'44047449865', admin: false)

        Lot.create!(code: 'GAD459812', start_date:'04-04-2022',limit_date:'04-05-2022',min_value:1000.00,
                        dif_value:500.00, aproved:false, user:user)

        Lot.create!(code: 'GAD459232', start_date:'04-04-2022',limit_date:'04-05-2022',min_value:2000.00,
            dif_value:600.00, aproved:true, user:user)

        login_as(user)

        visit root_path
        click_on "Lotes para leilão"
  
        expect(page).not_to have_content 'Visualizar todos os lotes'
        expect(page).to have_content 'GAD459232'
        expect(page).to have_content '04/04/2022'
        expect(page).to have_content 'R$2000.0'
        expect(page).not_to have_content 'GAD459812'
        
    end

end