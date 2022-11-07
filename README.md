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

>Git e GitHub são duas ferramentas bastante utilizadas no mundo da computação e também serão usadas para o desenvolvimento do Pset1 proposto pelo professor Abrantes. Através delas que serão criados os scripts em linguagem sql, demonstrando a implementação do banco de dados Hr aos SGBDs Postgresql e MySQL.

## Construção do projeto lógico o software sql power architect
Para implementar qualquer banco de dados à um sgbd, é necessário uma série de etapas para a construção de um modelo sólido e íntegro, pois só assim, através de etapas como a contrução de  projetos conceituais e lógicos obteremos um banco de dados funcional, inibindo o máximo possivel de erros que possam a vir comprometer a estrutura do projeto já aplicado. Com isso, um projeto lógico bem construido resultada diretamente em um banco de dados funcional, e é justamente esse objetivo proposto eplo Profº Abrantes, ao instruir a replicagem de um modelo lógico pré existente, de forma a corrigir erros presentes e aprender sobre a ferramenta para a construção de projetos lógicos SQL PowerArchtect, muito utilizada por profissionais da área.

### SQL PowerArchtect
Essa ferramenta para a modelagem lógica dos dados, apresenta interface simples e intuitiva para a construção dos projetos, de forma que uma pessoa iniciante assim como eu, em poucas horas utilizando-a consiga facilmente desenvolver um projeto completo explorando todas as ferramentas e recursos disponibilizados. Criar tabelas, colunas, relacionamentos, definir cardinalidades e restrições, são apenas alguns dos recursos que você certamente irá utilizar ao desenvolver um projeto, e que estão presentes no PowerArchtect configurando-se como uma ferramenta bem completa.  

### Erros identificados:
Como mencionado pelo porfessor o exemplo de modelo lógico oferecido para os alunos replicarem no sql power architect foi construido contendo alguns erros propositais, feitos justamente para o professor avaliar nossa compreensão e capacidade sobre resolução de problemas. Ao replicar o modelo lógico pré existente, consegui notar a existência dos seguintes erros:

- Da tabela regioes para a tabela paises; Na tabela paises a coluna em que se encontra a chave estrangeira vinda da tabela regioes, é apresentada com dados inconsistentes, uma vez que na tabela regioes a coluna id_regiao que por definição é sua Primary key apresenta atributos INTEGER e NOT NULL, o que também teria que ser replicado à sua chave estrangeira na tabela paises que não apresenta os mesmos atributos, apenas INTEGER ausentado o atributo NOT NULL.

- Da tabela pais para a tabela localizacoes; Na tabela pais a coluna definidade como sua Primary Key(PK) id_pais possui atributos CHAR(2) e NOT NULL, no entanto este mesmo campo referenciado na tabela localizacoes com uma foreign key(FK), não possui o mesmo atributo NOT NULL, consfigurando erro.

- Da tabela localizacao para a tabela departamento; A primary key (PK) presente na tabela localizacao (id_localizacao) é referenciada na tabela departamento como uma chave estrangeira, no entanto nesta tabela ela não possui o atributo NOT NULL que o mesmo campo possui na sua tabela de origem, configurando erro.

- O mesmo ocorre da tabela departamento para a tabela empregado; Onde a chave primaria da tabela departamento (id_departamento) é referenciada na tabela empregado sem o atributo NOT NULL.

- A tabela departamento possui uma Chave estrangeira(FK) no campo id_gerente, porem este campo não faz referência a nenhuma outra coluna de nenhuma outra tabela, dentro do projeto lógico.

- Na tabela empregados; a coluna id_supervisor está presente na tabela como uma chave estrangeira(FK), porém ela não faz referência à nenhuma outra coluna de nenhuma outra tabela. E ainda possui logo abaixo da tabela uma cardinalidade ligando a caluna nela mesma.

- No projeto lógico disponibilado pelo professor abrantes, da tabela empregados para a tabela departamentos há uma cardinalidade de 1:N respectivamente, entretanto a PK da tabela empregados(id_empregado) não está referenciada em nenhuma outra coluna presente na tabela departamentos. A partir dessa análise é possivel observar o erro recorrente.

-  Na tabela historico_cargos a coluna id_cargo definidade como uma chave estrangeira(FK) vinda da tabela de cargos possui atributo _varchar_ diferente de sua coluna de origem na tabela cargos que é _varchar(10)_

- Cardinalidade entre a tabela de empregados e a tabela de histórico_cargos; No modelo disponibilizado a cardinalidade entre as duas aparece como não identificada quando correto seria identificada, uma vez que o histórico de cargos necessita de um empregado para existir.


- As cardinalidades de regioes para paises e de paises para localizações; A tabela regiões para a tabela paises o relacionamento é lido de forma que 1 regiao pode possuir 0,1,2,3 ou mais paises, porém uma região não pode ser composta por nenhum pais(0), então o correto relacionamento seria 1 região possui 1,2,3 ou mais paises. 
O mesmo ocorre da tabela paises para a tabela de localizações, sendo este relacionamento lido da seguinte forme: 1 pais possui 0,1,2,3 ou mais localizações, porém também está incorreto pois um pais possui obrigatoriamente diversas regiões, sendo o relacionamento correto: 1 pais possui 1,2,3 ou mais localizações.

No entanto estes erros de forma relativamente simples foram corrigidos, mantendo a integridade do projeto lógico. 

### Auto relacionamento de uma tabela: Elemento presente no modelo lógico de referência, cujo caracteristicas eram desconhecidas, fazendo com que buscasse informações sobre

### Ao inciar o processo de construção do projeto lógico, me deparo com um elemento ainda não estudado em sala de aula, as Alternate Key(AK)

. Postgres oferece mais funcionalidades e uma melhor organização para o ambiente corporativo.

## Iniciando a criação do Script em SQL para implementar o modelo lógico construido aos SGBDs Postgresql e MySql