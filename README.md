# README

# Leilão de Lotes

Sistema criado a fim de ilustrar de maneira simples e básica um leilão de lotes de itens.


# Gems usadas
gem "cpf_cnpj"

# Como usar o sistema
Ao executar o rails s, um seed contendo algumas informações pré cadastradas será executado. Neste seed existirá um lote cujo a validade se encontra expirada, ou seja, não será possível realizar lances. Esse lote terá 3 lances, então siga esses passos:

Acesse como administrador, na página principal:

Lotes para leilão > Lotes expirados > finalizar

O resultado será calculado.

Neste exemplo, o usuário eduardo@gmail.com será o vencedor do leilão. Logue com essa conta para receber a notificação.

# Contas para acessar o sistema

admins: 
diniz@leilaodogalpao.com.br - senha: banana123
eduardo@leilaodogalpao.com.br - banana123

Usuário comum
eduardo@gmail.com - banana123


# Observações

As datas do lote são do time Date, então por enquanto não será possível calcular através de horas e minutos.

Fiz o mais básico possível por falta de tempo. Mas temos um leilão funcionando hahaha.








