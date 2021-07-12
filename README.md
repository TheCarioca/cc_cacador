![alt text](https://i.imgur.com/i2CODhn.png)

# Emprego - Caçador
# By Carioca
Com a intenção de revolucionar os empregos do FiveM, a Carioca Community oferece o Emprego de Caçador. Basicamente, você receberá o trabalho de caçar e abater os veados da cidade. Esse sistema possui o básico de todas as funcionalidades necessários para um emprego de caçador, mas com uma qualidade extraordinal.
Além disso, foi preparado um arquivo de configuração, para que você possa ajustar o script da maneira que achar melhor.

- **Teaser Oficial: https://www.youtube.com/watch?v=PCDm4BD4FIU**

## Etapas do Emprego:
```
1. Entrar em serviço na coordenada: ['x'] = -773.14, ['y'] = 5598.59, ['z'] = 33.61
2. Aparecerá um veículo e os animais serão spawnados e marcados em seu mapa.
3. Após ter abatido um veado, se você se aproximar e pressionar [E], você irá coletar os itens do animal.
4. Em seguida, você deve se direcionar para vender os itens coletados na coordenada a seguir: 
['x'] = 985.95, ['y'] = -2121.1, ['z'] = 30.48
```

## Instalação:
```
1. Colar ambas as pastas em sua pasta de resource: nav_cacador e cc_cacador.
2. Ir em seu vrp para adicionar os itens:
  a. Em vrp\cfg:
  ["carnedeveado"] = { "Carne de Veado",0.1 },
  ["couro"] = { "Couro",0.1 },
  b. Em vrp\modules:
  ["carnedeveado"] = { index = "carnedeveado", nome = "Carne de Veado", type = "usar" },
	["couro"] = { index = "couro", nome = "Couro", type = "usar" },
3. Por fim, basta iniciar os scripts.
  ensure nav_cacador
  ensure cc_cacador
```

## Configuração:
```
Temos dois arquivos necessários de configuração: nav_cacador\server.lua & cc_cacador\config.lua
```

## Está tendo problemas para baixar?
Caso o download da base esteja corrompendo, baixe utilizando o [GitHub Desktop](https://desktop.github.com).

## Suporte
Vale ressaltar, que o determinadas funções possam apresentar problemas de acordo com sua base. Caso haja, entre em nosso [Discord](https://discord.gg/w6wK9MW4cW).

## Contato
- **Servidor Discord: https://discord.gg/kYFy8JwVfd**
- **Discord: ropii#0001**
