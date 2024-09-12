<p align="center">
  <img
    src="https://img.shields.io/badge/Status-Em%20desenvolvimento-green?style=flat-square"
    alt="Status"
  />
</p>

<p align="center">
  <img
    src="https://img.shields.io/github/repo-size/Thomazrlima/Godot-Top-Down?style=flat"
    alt="Repository Size"
  />
  <img
    src="https://img.shields.io/github/languages/count/Thomazrlima/Godot-Top-Down?style=flat&logo=python"
    alt="Language Count"
  />
  <img
    src="https://img.shields.io/github/commit-activity/t/Thomazrlima/Godot-Top-Down?style=flat&logo=github"
    alt="Commit Activity"
  />
  <a href="LICENSE.md"
    ><img
      src="https://img.shields.io/github/license/Thomazrlima/Godot-Top-Down"
      alt="License"
  /></a>
</p>


# 2D Top-Down Combat Prototype

Este projeto é um protótipo de combate 2D no estilo top-down, desenvolvido na **Godot Engine**. O jogador controla um personagem que pode atacar inimigos com projéteis e desviar de ataques usando uma habilidade de dash. O objetivo é sobreviver ao máximo tempo possível enquanto elimina os inimigos.

## Requisitos Principais

### Personagem Principal (Player)

- **Movimentação com WASD**:  
  O jogador controla o personagem utilizando as teclas W, A, S, D para movimentação em um plano 2D. A movimentação deve ser fluida e precisa.

- **Animações com Sprites**:  
  Animações para as direções de movimento (cima, baixo, esquerda e direita), com transições suaves entre as animações.

- **Atirar Projéteis com o Clique Esquerdo do Mouse**:  
  O jogador pode disparar projéteis na direção do cursor com o botão esquerdo do mouse. A velocidade e direção dos projéteis são configuráveis. O projétil destrói o inimigo ao atingi-lo.

- **Dash com Barra de Espaço**:  
  O jogador pode realizar um dash pressionando a barra de espaço, movendo-se rapidamente em uma direção por uma curta distância. Inclui um breve período de invulnerabilidade e cooldown para balancear o jogo.

### Inimigos (Mob)

- **IA Básica para Seguir o Player**:  
  Inimigos se movem continuamente na direção do jogador. A IA é simples, mas desafiadora.

- **Morre Após Ser Atingido por 2 Projéteis**:  
  O inimigo é destruído após ser atingido por dois projéteis do jogador. Uma animação ou efeito visual indica sua morte.

- **Ao Tocar no Player, Game Over**:  
  Caso o inimigo toque o jogador, o jogo termina com uma tela de "Game Over" e a opção de reiniciar.

- **Animações com Sprites**:  
  Assim como o jogador, os inimigos possuem animações de movimento que refletem suas ações e direção.

### Cenário (Background)

- Um cenário básico (background) será utilizado como referência visual do ambiente de jogo.

### Barra de HP ou Números para Player e Mob

- O jogador e os inimigos possuem barras de HP visíveis ou números que indicam sua vida restante. A barra do jogador diminui ao ser tocado pelos inimigos, e a dos inimigos diminui com cada projétil.

### Menu Principal e Menu de Game Over

- **Menu Principal**: Uma tela inicial com a opção de iniciar o jogo.
- **Tela de Game Over**: Aparece quando o jogador perde, com a opção de reiniciar o jogo.

## Tecnologias Utilizadas

- **Engine**: Godot Engine
- **Linguagem de Script**: GDScript

## Como Jogar

1. Use as teclas **W**, **A**, **S**, **D** para mover o personagem.
2. Clique com o **botão esquerdo do mouse** para atirar projéteis.
3. Pressione a **barra de espaço** para realizar o dash.
4. Evite os inimigos e destrua-os com projéteis.

## Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
