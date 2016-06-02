using DataFrames

# Número de linhas para carregar para o DataFrame
numLinhas = 350000
artSearch = "Pink Floyd" #"Deep Dish" #"Judge D"

# Carregar Arquivos para DataFrames
dfRegistro = readtable("userid-timestamp-artid-artname-traid-traname.tsv", nrows = numLinhas)
#dfUser = readtable("userid-profile.tsv")

#Filtrar Usuários que também ouviram o artista ou banda
dfFill = dfRegistro[dfRegistro[:artname] .== artSearch, :]

#Agrupar por id de usuário
dfFill = by(dfFill, :_id, nrow)

# Fazer o join por userID para recuperar as outras bandas ouvidas pelos usuários.
j = join(dfRegistro, dfFill, on = :_id)

#agrupa por nome do artista e lista os mais escutados em ordem decrescente.
dfResult = sort( by(j, :artname, nrow) , cols = :x1, rev=true)

println(dfResult)
