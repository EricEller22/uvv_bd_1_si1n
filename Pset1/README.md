# **Pset 1**
## Aluno: Eric Andrade Eller 
## Profº: Abrantes Araújo Silva Filho

Dentro deste subdiretório está disponível a documentação referente ao desenvolvimento do Pset-1 da disciplina de Design e Desenvolvimento de banco de dados.


## Inicio do processo
O primeiro passo para a realização da atividade proposta pelo professor Abrantes, é o apreendizado sobre o _Version Control System (VCS)_ **Git** + a plataforma de hospedagem de códigos-fonte **GitHub**, utilizados amplamente por profissionais da tecnologia para o gerenciamento e controle das versões de um projeto. O uso dessas ferramentas se torna indispenável para aqueles que desejam gerir projetos e manter o controle sobre os mesmos, possuindo diversas funcionalidades e ferramentas que auxiliam ao desenvolver um software ou aplicação web por exemplo.


>Explicando um pouco mais à fundo sobre as ferramentas comentadas:
### Git
Como já mencionado GIT se trata de um sistema de controle de versões, um software utilizado para gerenciar e administrar ad diferentes versões de um projeto ao decorrer de seu desenvolvimento. Este sistema é de suma importância, pois atravéz dele é possivel criar, editar, salvar e revisar os arquivos de um projeto, seja um código fonte ou até mesmo esta documentação que você está lendo.

Iniciando os estudos sobre o GIT através de uma série de artigos online e de videos aulas, já é possivel começar a usar o software. Seja atravéz de uma interface gráfica que é mais simplificada, ou até mesmo pelo GIT BASH a linha de comando do GIT, que na minha particular opinião é bem mais fácil de ser utilizada, necessitando apenas de um estudo mais profundo, mas que trará diversas facilidades ao longo prazo utilizando-o.

- Dificuldades: 
Para os iniciantes que começaram a utilizar este sistema a um curto periodo de tempo, uma das principais dificuldade é entender como o GIT funciona na prática e como operá-lo de forma funcional, quais comandos utilizar, como criar um repositório GIT e principalmente como utilizar o GIT para editar, salvar e consultar as diferentes versões do seu projeto. Essas são duvidas frequentemente geradas, mas que com um pequeno esforço de estudo e pesquisa conseguem ser sanadas.

[Sugestão de curso para se aprofundar em GIT.](https://youtube.com/playlist?list=PLucm8g_ezqNq0dOgug6paAkH0AQSJPlIe)

### GitHub
Para os mais leigos GitHub pode ser a mesma coisa que o GIT, porém não é bem essa a definição correta. GitHub é uma plataforma onde é possivel armazenar diferentes tipos de projetos, sendo uma espécie de rede social para desenvolvedores, e que possui elementos do GIT incorporados em sua estrutura e funcionamento.

Diferentemente do Git o GitHub não necessita de conhecimento prévio para ser utilizado, uma vez que sua interface é apresentada de forma bem intuiva e minimalista, disponibilizando apenas o necessário para seus usuários utilizarem-o. No entanto, se você possui familiaridade com a lingua inglesa(O que não é o meu caso) você tera ainda mais facilidades ao utilizar o GitHub, mas não só ele, qualquer outro software proporciona entendimento facilitado perante ao prévio entendimento do Inglês.

### MakDown
MarkDown se trata de um linguagem de marcação de texto puro, criada principalmente para proporcionar facil conversão dos seus documentos para html, uma vez que o markdown é baseado na própria sintaxe html, apresemtando elementos de conversão direta para a linguagem, como por emxemplo.

- Em mardown: #, ##, ### ...
- Em Html: H1, H2, H3 ...


>Git e GitHub e linguagem MarkDown são ferramentas bastante utilizadas no mundo da computação e também serão usadas para o desenvolvimento do Pset1 proposto pelo professor Abrantes. Através delas que serão criados todos os documentos e scripts em linguagem sql, demonstrando a implementação do banco de dados Hr aos SGBDs Postgresql e MySQL.


## Construção do projeto lógico o software sql power architect
Para implementar qualquer banco de dados à um sgbd, é necessário uma série de etapas para a construção de um modelo sólido e íntegro, pois só assim, através de etapas como a contrução de  projetos conceituais e lógicos obteremos um banco de dados funcional, inibindo o máximo possivel de erros que possam a vir comprometer a estrutura do projeto já aplicado. Com isso, um projeto lógico bem construido resultada diretamente em um banco de dados funcional, e é justamente esse objetivo proposto pelo Profº Abrantes, ao instruir a replicagem de um modelo lógico pré existente, de forma a corrigir erros presentes e aprender sobre a ferramenta para a construção de projetos lógicos SQL PowerArchtect, muito utilizada por profissionais da área.

### SQL PowerArchtect
Essa ferramenta para a modelagem lógica dos dados, apresenta interface simples e intuitiva para a construção dos projetos, de forma que uma pessoa iniciante assim como eu, em poucas horas utilizando-a consiga facilmente desenvolver um projeto completo explorando todas as ferramentas e recursos disponibilizados. Criar tabelas, colunas, relacionamentos, definir cardinalidades e restrições, são apenas alguns dos recursos que você certamente irá utilizar ao desenvolver um projeto, e que estão presentes no PowerArchtect configurando-se como uma ferramenta bem completa.  
 
### Erros identificados:
Como mencionado pelo porfessor o exemplo de modelo lógico oferecido para os alunos replicarem no sql power architect foi construido contendo alguns erros propositais, feitos justamente para o professor avaliar nossa compreensão e capacidade sobre resolução de problemas. Ao replicar o modelo lógico pré existente, consegui notar a existência dos seguintes erros:

1. __Da tabela regioes para a tabela paises:__ Na tabela paises a coluna em que se encontra a chave estrangeira vinda da tabela regioes, é apresentada com dados inconsistentes, uma vez que na tabela regioes a coluna id_regiao que por definição é sua Primary key apresenta atributos INTEGER e NOT NULL, o que também teria que ser replicado à sua chave estrangeira na tabela paises que não apresenta os mesmos atributos, apenas INTEGER ausentado o atributo NOT NULL.

2. __Da tabela pais para a tabela localizacoes:__ Na tabela pais a coluna definidade como sua Primary Key(PK) id_pais possui atributos CHAR(2) e NOT NULL, no entanto este mesmo campo referenciado na tabela localizacoes com uma foreign key(FK), não possui o mesmo atributo NOT NULL, consfigurando erro.

3. __As cardinalidades de regioes para paises e de paises para localizações:__ A tabela regiões para a tabela paises o relacionamento é lido de forma que 1 regiao pode possuir 0,1,2,3 ou mais paises, porém uma região não pode ser composta por nenhum pais(0), então o correto relacionamento seria 1 região possui 1,2,3 ou mais paises. 
O mesmo ocorre da tabela paises para a tabela de localizações, sendo este relacionamento lido da seguinte forme: 1 pais possui 0,1,2,3 ou mais localizações, porém também está incorreto pois um pais possui obrigatoriamente diversas regiões, sendo o relacionamento correto: 1 pais possui 1,2,3 ou mais localizações.

4. __Da tabela localizacao para a tabela departamento:__ A primary key (PK) presente na tabela localizacao (id_localizacao) é referenciada na tabela departamento como uma chave estrangeira, no entanto nesta tabela ela não possui o atributo NOT NULL que o mesmo campo possui na sua tabela de origem, configurando erro, uma vez que um departamento tem que estar associado a uma certa localização.

5.  __Na tabela historico_cargos:__ Na coluna id_cargo definidade como uma chave estrangeira(FK) vinda da tabela de cargos possui atributo _varchar_ diferente de sua coluna de origem na tabela cargos que é _varchar(10)_.

6. __Cardinalidade entre a tabela de empregados e a tabela de histórico_cargos:__ No modelo disponibilizado a cardinalidade entre as duas aparece como não identificada quando correto seria identificada, uma vez que o histórico de cargos necessita de um empregado para existir.

>No entanto estes erros de forma relativamente simples foram corrigidos, mantendo a integridade do projeto lógico. 


### Novos conceitos aprendidos:
Ao realizar a modelagem do projeto lógico, me deparei com uma série de elementos e conceitos anteriormente desconhecidos e que consequentemente me forçaram a aprender e entender sobre eles, de forma a consultar documentos, video-aulas e diversos blogs, afim de sanar as mais diversas dúvidas recorrentes, com por exemplos sobre os seguintes elementos:

- __Auto relacionamento de uma tabela:__ Utilizado para definir um campo em uma tabela cujo sua chave estrangeira(FK) ao invés de referênciar a chave primária(PK) de outra tabela, referência e extrai dados da chave primária da própria tabela em que está inserida.

- __Alternate Key(AK):__ Alternate Key ou Chave única é como se ela fosse ,assim com uma chave primária, um identificador para aquela tabela respeitando parâmetros um pouco mais flexíveis, podendo ser um campo null por exemplo.

- __Tipos de relacionamento:__ Relacionamento identificado expressa uma relação entre tabelas, onde a chave estrangeira faz parte da chave primária daquela tabela, ou seja, faz parte da identificação da mesma gerando uma chave primária composta(PFK), enquanto o Relacionamento não-identificado não faz parte de uma chave primária.


## Iniciando a criação do Script em SQL para implementar o modelo lógico construido aos SGBDs Postgresql e MySql
Após criar, editar e finalizar o projeto lógico iniciei a criação do script para implementar o banco de dados hr, primeiramente ao SGBD Postgresql e posteriormente ao SGBD MySql. 

### Implementando ao Postgresql
O primeiro passo ao iniciar a criação do script foi verificar a documentação do Postgres buscando entender a forma como o sgbd funciona e opera, pois não possuia conhecimento prévio sobre o mesmo. Ao estudar o postgres notei que, esse se trata de um dos SGBDs mais completo para produtividade disponiveis hoje em dia, apresentando funções e recursos voltados para um melhor gerenciamento dos bancos de dados, possibilitando administrar permissões, papéis, usuário e diversos outros elementos. 
No entanto, o postgres apresenta certa complexidade para ser utilizado, uma vez que, diversas funções padrões do SQL são modificadas para atender à comandos exclusivos do postgres, como por exemplo para selecionar um banco de dados:

* No MySql:

~~~sql
USE uvv;
~~~

* No Postgres:

~~~sql
\c uvv;
~~~

>Comandos de certa forma simples mas que podem causar estranhamento para aqueles que ainda não estão acostumados.

E para criar o corretamente o script, o processo foi divido em 4 etapas ao todo:

1. Criar os comandos administrativos para criação de usuários, banco de dados e schemas.
2. Inserir os comandos pré-criados no SqlPowerArchtect, fazendo pequenas mudanças e corrigindo pequenos erros.
3. Inserir os dados importados do banco de dados hr legitimo.
4. Testar o script depois de pronto, corrigindo erros e fazendo pequenos ajustes. 

>E ao passar dessas 4 etapas, o script para a implementação do banco de dados hr se encontrava pronto.

### Implementando ao MySql
Processo semelhante ocorreu para implementar o script ao MySql, no entando de certa forma mais fácil, uma vez que, pequenos ajustes foram feitos no script do Postgres para adiciona-lo ao Mysql, como por exemplo:

1. Mudança nos comandos para criar usuário, banco dados e para entrar no banco de dados.
2. Mudança nos comando para comentar tabelas e colunas.
3. Mudança nos comandos para criar Chaves estrangeiras(FK).

>Aplicando essas modificações, finalizei a criação dos scripts.

## Parecer sobre o Pset1

Realmente um desafio. 

Através dessa atividade, do estudo, do esforço e da capacidade de resolução de problemas exigidos por ela, um ponto certamente marcante foi a quantidade de conhecimento obtido ao ter a oportunidade de botar a mão na massa e ver como as coisas realmente funcionam na prática, proporcionando o necessário para que possamos ir sempre além, do desgaste, da dificuldade e dos desafios. Foi um processo cansativo sim, mas que trouxe e trará ainda mais frutos de conhecimento para nos tornarmos porfissionais execpcionais.

>Com essa frase termino por aqui esse 1º Pset

__Se deparar com o desconhecido em um primeiro momento pode parecer impossivel, no entanto lembre-se, *"O impossível é um lugar que só existe na cabeça de todos os que desistem."*__
