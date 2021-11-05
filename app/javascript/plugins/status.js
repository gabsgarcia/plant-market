  const botao = document.getElementsByClassName("icone");

  const acao = 'click';

  const funcao = () => {
    const faspa = document.querySelector("fas");
    faspa.classList.add('green');
  }

  botao.addEventListener(acao, funcao);
