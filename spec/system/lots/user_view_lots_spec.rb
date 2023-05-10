require 'rails_helper'

describe 'A partir da tela inicial' do 
    it 'aprovados em andamento' do 
        user = User.create!(email:'eduardo@leilãoestoque.com.br', password: 'eduardo123',cpf:'44047449865', admin: false)

        Lot.create!(code: 'GAD459812', start_date:'10-05-2023',limit_date:'04-06-2023',min_value:1000.00,
                        dif_value:500.00, aproved:true, user:user)

        Lot.create!(code: 'JAE459812', start_date:'10-05-2023',limit_date:'10-06-2023',min_value:1000.00,
            dif_value:500.00, aproved:true, user:user)


        visit root_path

        expect(page).to have_content 'Lotes em andamento'
        expect(page).to have_content 'GAD459812'
        expect(page).to have_content '10/05/2023'

        expect(page).to have_content 'JAE459812'
        expect(page).to have_content '10/05/2023'

    end

    it 'aprovados futuros' do 
        user = User.create!(email:'eduardo@leilãoestoque.com.br', password: 'eduardo123',cpf:'44047449865', admin: false)

        Lot.create!(code: 'BED459232', start_date:'05-06-2023',limit_date:'05-07-2023',min_value:2000.00,
            dif_value:600.00, aproved:true, user:user)

        Lot.create!(code: 'TED459232', start_date:'10-06-2023',limit_date:'05-07-2023',min_value:2000.00,
            dif_value:600.00, aproved:true, user:user)

        visit root_path

        expect(page).to have_content 'Lotes futuros'
        expect(page).to have_content 'BED459232'
        expect(page).to have_content '05/06/2023'

        expect(page).to have_content 'TED459232'
        expect(page).to have_content '10/06/2023'

    end
    
end