
import 'package:flutter/material.dart';
/*O aplicativo possui alguns produtos com imagens, nomes e preços. Vamos adicionar isso aos widgets que já temos no cartão
Em seguida, home.dartimporte um novo pacote e alguns arquivos que fornecemos para um modelo de dados:*/
import 'package:flutter/foundation.dart';
//import 'package:intl/intl.dart';

import 'model/products_repository.dart';
//import 'model/product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /*lista para criar uma coluna de imagens com rolamento de tela*/
  /*uma função que pode gerar quantos cartões vazios quisermos e retorna uma lista de cartões.*/
  /*Por fim, altere _buildGridCards()para buscar as informações do produto e use esses dados nos cartões:*/
  List<Card> _buildGridCards(BuildContext context) {
   List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString());

  return products.map((product){
       return Card(
      clipBehavior: Clip.antiAlias,
      // TODO: Adjust card heights (103)
      child: Column(
        // TODO: Center items on the card (103)
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 11,
            child: Image.asset(
              
              product.assetName,
              package: product.assetPackage,
             // TODO: Adjust the box size (102)
             fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
               // TODO: Align labels to the bottom and center (103)
               crossAxisAlignment: CrossAxisAlignment.start,
                // TODO: Change innermost Column (103)
                children: <Widget>[
                 // TODO: Handle overflowing labels (103)
                 Text(
                    product.name,
                    style: theme.textTheme.title,
                    maxLines: 1,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    formatter.format(product.price),
                    style: theme.textTheme.body2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*adicione uma AppBar ao andaime:
      A adição da AppBar ao appBar:campo do andaime fornece um layout perfeito gratuitamente,
      mantendo a AppBar na parte superior da página e o corpo embaixo.*/
      appBar: AppBar(
        /*adicione um título à AppBar*/
        title: Text("Qualquer Lugar"),
        centerTitle: true,
        backgroundColor: Colors.grey,
        /*Enquanto ainda estiver dentro home.dart, defina um IconButton para o leading:campo da AppBar .
        (Coloque-o antes do title:campo para imitar a ordem que segue para a direita):*/
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print("Menu button");
          },
        ),
        /*Agora, o aplicativo tem um botão à esquerda, um título e duas ações no lado direito. 
        A barra de aplicativos também exibe a elevação usando uma sombra sutil que mostra que ela está em uma camada diferente do conteúdo.*/
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print("Search button");
            },  
          )
        ],
      ),
      /*Vamos começar adicionando um cartão abaixo da barra de aplicativos superior. 
      O widget Card sozinho não tem informações suficientes para se mostrar onde poderíamos vê-lo; portanto, queremos encapsulá-lo em um widget GridView .*/
      /*Vamos descompactar esse código. O GridView chama o count()construtor, pois o número de itens exibidos é contável e não infinito. 
      Mas ele precisa de algumas informações para definir seu layout.*/
      body: GridView.count(
        /*O crossAxisCount:especifica quantos itens estão. Queremos 2 colunas.*/
        crossAxisCount: 2,
        /*O padding:campo fornece espaço nos quatro lados do GridView.*/
        padding: EdgeInsets.all(16.0),
        /*O childAspectRatio:campo identifica o tamanho dos itens com base em uma proporção (largura sobre altura).
        Por padrão, o GridView cria blocos do mesmo tamanho.*/
        /*Acrescentando que todos juntos, o GridView calcula a largura de cada criança como se segue: ([width of the entire grid] - [left padding] - [right padding]) / number of columns.
         Usando os valores temos: ([width of the entire grid] - 16 - 16) / 2. A altura é calculada a partir da largura, aplicando a proporção :: ([width of the entire grid] - 16 - 16) / 2 * 9 / 8. 
         Invertemos 8 e 9 porque estamos começando com a largura e calculando a altura e não o contrário.*/
        childAspectRatio: 8.0 / 9.0,
      
        children: _buildGridCards(context)
      ),
    );
  }
}
