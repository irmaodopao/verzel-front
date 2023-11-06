# verzel-front

Front-end em Flutter com as seguintes funcionalidades disponíveis:
- Home Page pública exibindo uma vitrine de veículos ✔️
- Ordenação por valor ✔️
- Tela de login admnistrativo com tokenJWT ✔️
- CRUD de novos veículos ✔️
- Upload de foto do veículo ✔️
- token de request ✔️
- token expired ✔️

# Login ADM
Usuario: adm
Senha: adm

# Observações

- No início do app irá exibir uma vitrine de veículos
- O usuário, inicialmente, terá acesso a apenas uma ação que será o botão de "+" no canto inferior direito, no qual irá redirecioná-lo para a tela de login ADM
- Caso o usuário tente editar ou excluir algum veículo sem o login, o sistema o avisa que ele nao tem permissão de tais ações
- Após logado, irá gerar um tokenJWT que possuí duração de 1h e todas as ações de CRUD estarão liberadas
- Para cadastro de um veículo, basta apenas dar um clique ( apertar ) no botão de "+" que irá te redirecionar para a tela de cadastro de veículo
- Para exclusão de um veículo, basta apenas dar um clique ( apertar ) no veículo que deseja excluir que aparecerá um pop-up de confirmação de exclusão
- Para edição de um veículo, basta clicar ( apertar ) e segurar no veículo que deseja editar
- Caso o tokenJWT expire, você irá ser redirecionado para a tela de login ADM avisando-o que seu token expirou!
