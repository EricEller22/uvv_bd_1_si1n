# **Pset 1**
## Aluno: Eric Andrade Eller 
## Profº: Abrantes Araújo Silva Filho

Dentro deste subdiretório está disponível a documentação referente à realização do Pset-1 da disciplina de Design e Desenvolvimento de banco de dados.


## Inicio do processo
O primeiro passo para a realização da atividade proposta pelo professor Abrantes, é o apreendizado sobre o _Version Control System (VCS)_ **Git** + a plataforma de hospedagem de códigos-fonte **GitHub**, utilizados amplamente por profissionais da tecnologia para o gerenciamento e controle das versões de um projeto. O uso dessas ferramentas se torna indispenável para aqueles que desejam gerir projetos e manter o controle sobre os mesmos, possuindo diversas funcionalidades e ferramentas que auxiliam ao desenvolver um software ou aplicação web por exemplo.

>Explicando um pouco mais à fundo sobre as ferramentas comentadas:
### Git
-Comandos básicos:

-Dificuldades:

### GitHub

_dificuldades:


## Iniciando a construção do projeto lógico o software sql power architect

### Erros identificados:
Como mencionado pelo porfessor o exemplo de modelo lógico oferecido para os alunos replicarem no sql power architect foi construido contendo alguns erros propositais, feitos justamente para o professor avaliar nossa compreensão e capacidade sobre resolução de problemas.

-Da tabela regioes para a tabela paises; Na tabela paises a coluna em que se encontra a chave estrangeira vinda da tabela regioes, é apresentada com dados inconsistentes, uma vez que na tabela regioes a coluna id_regiao que por definição é sua Primary key apresenta atributos INTEGER e NOT NULL, o que também teria que ser replicado à sua chave estrangeira na tabela paises que não apresenta os mesmos atributos, apenas INTEGER ausentado o atributo NOT NULL.

-Da tabela pais para a tabela localizacoes; Na tabela pais a coluna definidade como sua Primary Key(PK) id_pais possui atributos CHAR(2) e NOT NULL, no entanto este mesmo campo referenciado na tabela localizacoes com uma foreign key(FK), não possui o mesmo atributo NOT NULL, consfigurando erro.

-Da tabela localizacao para a tabela departamento; A primary key (PK) presente na tabela localizacao (id_localizacao) é referenciada na tabela departamento como uma chave estrangeira, no entanto nesta tabela ela não possui o atributo NOT NULL que o mesmo campo possui na sua tabela de origem, configurando erro.

-O mesmo ocorre da tabela departamento para a tabela empregado; Onde a chave primaria da tabela departamento (id_departamento) é referenciada na tabela empregado sem o atributo NOT NULL.

-A tabela departamento possui uma Chave estrangeira(FK) no campo id_gerente, porem este campo não faz referência a nenhuma outra coluna de nenhuma outra tabela, dentro do projeto lógico.

-Na tabela empregados; a coluna id_supervisor está presente na tabela como uma chave estrangeira(FK), porém ela não faz referência à nenhuma outra coluna de nenhuma outra tabela. E ainda possui logo abaixo da tabela uma cardinalidade ligando a caluna nela mesma.

-No projeto lógico disponibilado pelo professor abrantes, da tabela empregados para a tabela departamentos há uma cardinalidade de 1:N respectivamente, entretanto a PK da tabela empregados(id_empregado) não está referenciada em nenhuma outra coluna presente na tabela departamentos. A partir dessa análise é possivel observar o erro recorrente.

-Na tabela historico_cargos a coluna id_cargo definidade como uma chave estrangeira(FK) vinda da tabela de cargos possui atributo _varchar_ diferente de sua coluna de origem na tabela cargos que é _varchar(10)_

--Cardinalidade entre a tabela de empregados e a tabela de histórico_cargos; No modelo disponibilizado a cardinalidade entre as duas aparece como não identificada quando correto seria identificada, uma vez que o histórico de cargos necessita de um empregado para existir.


--As cardinalidades de regioes para paises e de paises para localizações; A tabela regiões para a tabela paises o relacionamento é lido de forma que 1 regiao pode possuir 0,1,2,3 ou mais paises, porém uma região não pode ser composta por nenhum pais(0), então o correto relacionamento seria 1 região possui 1,2,3 ou mais paises. 
O mesmo ocorre da tabela paises para a tabela de localizações, sendo este relacionamento lido da seguinte forme: 1 pais possui 0,1,2,3 ou mais localizações, porém também está incorreto pois um pais possui obrigatoriamente diversas regiões, sendo o relacionamento correto: 1 pais possui 1,2,3 ou mais localizações.


### Auto relacionamento de uma tabela: Elemento presente no modelo lógico de referência, cujo caracteristicas eram desconhecidas, fazendo com que buscasse informações sobre

### Ao inciar o processo de construção do projeto lógico, me deparo com um elemento ainda não estudado em sala de aula, as Alternate Key(AK)