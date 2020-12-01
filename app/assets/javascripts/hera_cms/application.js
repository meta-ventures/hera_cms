console.log('Hera CMS Javascript ON');

// Seleciona todos os elementos editáveis da página
let editables = document.querySelectorAll('.js-editable')

// Adiciona/remove a edicao para todos os editaveis
const allowEdit = () => {
  editables.forEach((editable) => {
    editable.addEventListener('mouseenter', displayEditor);
    editable.addEventListener('mouseleave', hideEditor);
  });
};
const lockEdit = () => {
  editables.forEach((editable) => {
    editable.removeEventListener('mouseenter', displayEditor);
    editable.removeEventListener('mouseleave', hideEditor);
  });
};
// Remove editaveis quando toggle off é utilizado
const toggleOff = () => {
  // Remove outros forms possivelmente abertos
  let formBox = document.querySelector(".form-box");
  if(formBox){
    formBox.parentNode.removeChild(formBox);
  };
  // Remove highlight dos campos fechados
  editables.forEach((editable) => {
    if (editable.classList.contains('highlight-layer')){
      editable.classList.remove('highlight-layer');
    }
  });
  // Troca wrapper com editavel
  let wrapper = document.querySelector('.editable-wrapper');
  if(wrapper){
    wrapper.parentNode.replaceChild(wrapper.firstChild, wrapper);
  };
};


const toggle_edit_loader = (e) => {
  // Essa função altera entre o Modo edição e o Modo View.
  // No modo edição, todos os links, textos e imagens editáveis precisam ter um botão de editar quando o mouse passa por cima deles.
  // Esses eventos só podem existir no edit mode. No view mode nada acontece.

  // Objetivo geral da função: Adicionar ou remover eventos em todos os itens editáveis, para que quando o mouse passe por cima deles, mostre o botão de editar.

  const button = e.target;
  if (button.dataset["mode"] === "edit") {
    console.log('going to view mode');
    button.innerText = "Off"
    button.dataset["mode"] = "view"
    button.classList.toggle("edit-button-on");
    toggleOff();

    const layer = document.querySelector(".background-layer");
    document.body.removeChild(layer);
    const slickerLayer = document.querySelector(".slicker-layer");
    const slider = document.querySelector('.slick-track');
    slider.removeChild(slickerLayer);
    lockEdit();
  }
  else if (button.dataset["mode"] === "view") {
    console.log('going to edit mode');
    button.innerText = "On"
    button.classList.toggle("edit-button-on");
    button.dataset["mode"] = "edit"
    const layer = document.createElement("div");
    layer.classList.add('background-layer');
    const slickerLayer = document.createElement("div");
    slickerLayer.classList.add('slicker-layer');
    const slider = document.querySelector('.slick-track');
    slider.appendChild(slickerLayer);
    document.body.appendChild(layer);
    allowEdit();
  }
}

const displayEditor = (e) => {
  // Objetivo geral: Mostrar o botão de edição
  // -destacar o campo a ser editado
  e.target.classList.add('highlight-layer');
  e.target.addEventListener('click', createForm);
}

const hideEditor = (e) => {
  // Objetivo geral: Remover o botão de edição
  // -retirar campo destacado para edição
  e.target.classList.remove('highlight-layer');
  e.target.removeEventListener('click', createForm);
}

const createForm = (e) => {
  // Objetivo geral da função:
  // Criar um form para edição do elemento atual, a partir do dataset do mesmo.

  // Previne o click do link ao clicar no form
  e.stopImmediatePropagation();
  e.preventDefault();
  e.target.removeEventListener('click', createForm);
  lockEdit();

  // Seleciona o elemento a ser editado
  const editable = e.currentTarget

  // Obtém a base do formulário com o token de autenticidade do rails
  let form = createElementFromHTML(railsFormHTML());

  // Troca a rota do formulário para a rota correta de edição do elemento
  form.action = `/${editable.dataset['editableType']}/${editable.dataset['editableId']}`;

  form.enctype = 'multipart/form-data';

  // Adiciona um hidden input para utilizar corretamente o método patch

  let i = document.createElement("input");
  i.setAttribute('type', "hidden");
  i.setAttribute('name', "_method");
  i.setAttribute('value', 'patch');

  form.appendChild(i);

  // Adiciona os campos corretos no form para cada tipo de editável

  switch (editable.dataset['editableType']) {
    case 'links':
      form = linkForm(form, editable);
      break;
    case 'media_index':
      form = mediaForm(form, editable);
      break;
    case 'texts':
      form = textForm(form, editable);
      break;
    case 'forms':
       form = formForm(form, editable);
       break;
    default:
      console.log(`Tipo ${editable.dataset['editableType']} não identificado.`)
  }

  // Adiciona o botão de submit do formulário
  let s = document.createElement("input");
  s.setAttribute('type', "submit");
  s.setAttribute('value', "Atualizar");

  form.appendChild(s);

  // Adiciona um wrapper com o editavel e o formulário dentro
  let wrapper = document.createElement("div");
  wrapper.className = "editable-wrapper " + editable.className;
  editable.parentNode.insertBefore(wrapper ,editable);

  wrappedEditable = wrapper.appendChild(editable);

  // Inicializa o modal
  let formBox = document.createElement('div');
  formBox.classList.add("form-box");
  formBox.appendChild(form);
  wrapper.appendChild(formBox);
  let boxPositionY = wrapper.getBoundingClientRect().top + 150;
  let boxPositionX = wrapper.getBoundingClientRect().left + 150;
  let screenHeight = window.screen.height;
  let screenWidth = window.screen.width;
  let relativeY = (boxPositionY / screenHeight) * screenHeight;
  let relativeX = boxPositionX / screenWidth * screenWidth;
  console.log(relativeX);
  console.log(screenWidth/2);
  if(relativeX > screenWidth / 2){
    formBox.style.left = "-308px";
  }else{
    formBox.style.right = "-308px";
  };
  if(relativeY > screenHeight / 2){
    formBox.style.top = "-150px";
  }else{
    formBox.style.bottom = "-150px";
  };
  wrappedEditable.removeEventListener('mouseenter', displayEditor);
  wrappedEditable.removeEventListener('mouseleave', hideEditor);

  // Adiciona um botão para destruir o wrapper e o formulário
  let destroyButton = document.createElement("p");
  destroyButton.className = "form-destroy";
  destroyButton.innerHTML = "<i class='far fa-times-circle'></i> fechar";
  destroyButton.addEventListener('click', () => {
    if (wrapper.parentNode) {
      newEditable = wrapper.parentNode.replaceChild(editable, wrapper);
      wrapper.removeChild(formBox);
      editable.classList.remove('highlight-layer');
      bodyLayer.classList.remove('clickable');
      slickerLayer.classList.remove('clickable');
      allowEdit();
    }
  });

  let slickerLayer = document.querySelector('.slicker-layer');
  slickerLayer.classList.add('clickable');
  slickerLayer.addEventListener('click', () => {
    destroyButton.click();
  });

  let bodyLayer = document.querySelector('.background-layer');
  bodyLayer.classList.add('clickable');
  bodyLayer.addEventListener('click', () => {
    destroyButton.click();
  });

  form.appendChild(destroyButton)
}

const linkForm = (form, editable) => {

    // Adiciona um input de texto para editar o inner text do elemento
    i = document.createElement("input");
    i.setAttribute('type', "text");
    i.setAttribute('name', "link[path]");
    i.setAttribute('value', editable);

    form.appendChild(i);

    return form;
}

const mediaForm = (form, editable) => {

  // Adiciona um input de texto para editar o inner text do elemento
  i = document.createElement("input");
  i.setAttribute('type', "file");
  i.setAttribute('name', "media[upload]");

  form.appendChild(i);

  // Adiciona um input de texto para editar o inner text do elemento
  i = document.createElement("input");
  i.setAttribute('type', "hidden");
  i.setAttribute('name', "media[upload_cache]");

  form.appendChild(i);

  return form;
}

const textForm = (form, editable) => {
  console.log(editable);

  // Adiciona um input de texto para editar o inner text do elemento
  i = document.createElement("textarea");
  i.setAttribute('type', "text");
  i.setAttribute('name', "text[inner_text]");
  i.innerHTML = editable.innerText;
  i.setAttribute('value', editable.innerText);

  form.appendChild(i);

  return form;
}

const formForm = (form, editable) => {
  console.log(editable)
  console.log(form)
  i = document.createElement("input");
  i.setAttribute('type', "text");
  i.setAttribute('name', "form[send_to]");
  i.setAttribute('value', editable.getAttribute("data-mail"))
  form.appendChild(i)
  return form
}


const createElementFromHTML = (htmlString) => {
  // Cria um node element a partir de uma string HTML
  const div = document.createElement('div');
  div.innerHTML = htmlString.trim();

  return div.firstChild;
}


// Seleciona o botão de modo da view
const editButton = document.getElementById('hera-edit-button');

if (editButton) {
  // Permite alterar entre modo edição e modo view
  editButton.addEventListener('click', toggle_edit_loader)
}
