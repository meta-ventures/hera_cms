// console.log('Loading Hera CMS Javascript');

let editables = document.querySelectorAll('.hera-editable')

const AUTH_TOKEN = document.querySelector('meta[name=csrf-token]').attributes['content'].value;

const allowEdit = () => {
  // Add listeners for all editables [edit mode]
  editables.forEach((editable) => {
    editable.addEventListener('mouseenter', displayEditor);
    editable.addEventListener('mouseleave', hideEditor);
  });
};

const lockEdit = () => {
  // Remove listeners for all editables [view mode]
  editables.forEach((editable) => {
    editable.removeEventListener('mouseenter', displayEditor);
    editable.removeEventListener('mouseleave', hideEditor);
  });
};

const toggleOff = () => {
  // Remove open forms and remove highlights that could be still active [switching from edit to view mode]
  let formBox = document.querySelector(".hera-form-box");
  if(formBox){
    formBox.parentNode.removeChild(formBox);
  };

  editables.forEach((editable) => {
    if (editable.classList.contains('hera-highlight-layer')){
      editable.classList.remove('hera-highlight-layer');
    }
  });
  // Swap wrapper with editable one (?)
  let wrapper = document.querySelector('.hera-editable-wrapper');
  if(wrapper){
    wrapper.parentNode.replaceChild(wrapper.firstChild, wrapper);
  };
};


const toggleEditLoader = (e) => {
  // Select all editable elements on the page
  editables = document.querySelectorAll('.hera-editable')

  // Switches between Edit Mode and View mode
  // In edit mode, all editable links, texts and images need the following:
    // 1. One edit button that appears on hover
    // 2. When you click it, it opens a form that enables you to change the value of the content
  // This events can only exist on edit mode. On view mode nothing happens.

  const button = e.target;
  if (button.dataset["mode"] === "edit") {
    // console.log('Switching to view mode');
    button.innerText = "Off"
    button.dataset["mode"] = "view"
    button.classList.toggle("hera-edit-button-on");
    toggleOff();

    const layer = document.querySelector(".hera-background-layer");
    document.body.removeChild(layer);
    // const slickerLayer = document.querySelector(".slicker-layer");
    // const slider = document.querySelector('.slick-track');
    // slider.removeChild(slickerLayer);
    lockEdit();
  }
  else if (button.dataset["mode"] === "view") {
    // console.log('Switching to edit mode');
    button.innerText = "On"
    button.classList.toggle("hera-edit-button-on");
    button.dataset["mode"] = "edit"
    const layer = document.createElement("div");
    layer.classList.add('hera-background-layer');
    // const slickerLayer = document.createElement("div");
    // slickerLayer.classList.add('hera-slicker-layer');
    // const slider = document.querySelector('.slick-track');
    // slider.appendChild(slickerLayer);
    document.body.appendChild(layer);
    allowEdit();
  }
}

const displayEditor = (e) => {
  // Shows the edit button for an element
  // highlith the field to be edited
  e.target.classList.add('hera-highlight-layer');
  e.target.addEventListener('click', createForm);
}

const hideEditor = (e) => {
  // Removes the edit button for an element
  // remove highlighted field
  e.target.classList.remove('hera-highlight-layer');
  e.target.removeEventListener('click', createForm);
}

const sendRequest = (e) => {
  e.preventDefault();
  form = e.target;

  let url = form.action + "?&authenticity_token=" + encodeURIComponent(AUTH_TOKEN);

  options = {
    method: "PUT",
    body: new FormData(form)
  };

  // console.log("fetching");
  fetch(url, options)
  .then(response => response.json())
  .then((data) => {
    window.location.replace(data.redirect);
  });

  // console.log('end');
}

const createForm = (e) => {
  // Create a form to update the content of element in the database, using its dataset

  // Prevent the link click when clicks on the form, and the default form behavior
  e.stopImmediatePropagation();
  e.preventDefault();
  e.target.removeEventListener('click', createForm);
  lockEdit();

  // Selects the element to be edited
  const editable = e.currentTarget

  // Creates the base form using rails autenthicity token
  let form = document.createElement("form");

  // Updates the form action to the proper element update route, using the datase
  form.action = `/hera_cms/${editable.dataset['editableType']}/${editable.dataset['editableId']}`;

  form.enctype = 'multipart/form-data';

  // Add a hidden input field to properly utilize the PATCH method

  let i = document.createElement("input");
  i.setAttribute('type', "hidden");
  i.setAttribute('name', "_method");
  i.setAttribute('value', 'patch');

  form.appendChild(i);

  // Add the proper inputs for each type of editable

  switch (editable.dataset['editableType']) {
    case 'links':
      form = linkForm(form, editable);
      break;
    case 'images':
      if (editable.dataset['editableUpload'] === "true") {
        form = imageUploadForm(form, editable);
      } else {
        form = imageUrlForm(form, editable);
      }
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

  // Add form submit button
  let s = document.createElement("input");
  s.setAttribute('type', "submit");
  s.setAttribute('value', "Atualizar");

  form.appendChild(s);

  // Add editable wrapper with form inside
  let wrapper = document.createElement("div");
  wrapper.className = "hera-editable-wrapper " + editable.className;
  editable.parentNode.insertBefore(wrapper ,editable);

  wrappedEditable = wrapper.appendChild(editable);

  // Creates and initializes the modal
  let formBox = document.createElement('div');
  formBox.classList.add("hera-form-box");
  formBox.appendChild(form);
  wrapper.appendChild(formBox);
  let boxPositionY = wrapper.getBoundingClientRect().top + 150;
  let boxPositionX = wrapper.getBoundingClientRect().left + 150;
  let screenHeight = window.screen.height;
  let screenWidth = window.screen.width;
  let relativeY = (boxPositionY / screenHeight) * screenHeight;
  let relativeX = boxPositionX / screenWidth * screenWidth;

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

  // Adds button to destroy wrapper and the form
  let destroyButton = document.createElement("p");
  destroyButton.className = "form-destroy";
  destroyButton.innerHTML = "x";
  destroyButton.addEventListener('click', () => {
    if (wrapper.parentNode) {
      newEditable = wrapper.parentNode.replaceChild(editable, wrapper);
      wrapper.removeChild(formBox);
      editable.classList.remove('hera-highlight-layer');
      bodyLayer.classList.remove('hera-clickable');
      allowEdit();
    }
  });


  let bodyLayer = document.querySelector('.hera-background-layer');
  bodyLayer.classList.add('hera-clickable');
  bodyLayer.addEventListener('click', () => {
    destroyButton.click();
  });

  form.appendChild(destroyButton);
  form.addEventListener('submit', sendRequest);
}

const linkForm = (form, editable) => {

  // Creates text input for the content of the element and appends it to the form
  pathInput = document.createElement("input");
  pathInput.setAttribute('type', "text");
  pathInput.setAttribute('name', "link[path]");
  pathInput.setAttribute('autocomplete', "off");
  pathInput.setAttribute('value', editable);

  form.appendChild(pathInput);

  // Creates text input for the content of the element and appends it to the form
  innerTextInput = document.createElement("input");
  innerTextInput.setAttribute('type', "text");
  innerTextInput.setAttribute('name', "link[inner_text]");
  innerTextInput.setAttribute('autocomplete', "off");
  innerTextInput.innerHTML = editable.innerText;
  innerTextInput.setAttribute('value', editable.innerText);

  form.appendChild(innerTextInput);
  return form;
}

const imageUploadForm = (form, editable) => {

  // Creates text input for the content of the element and appends it to the form
  i = document.createElement("input");
  i.setAttribute('type', "file");
  i.setAttribute('name', "image[upload]");

  form.appendChild(i);

  i = document.createElement("input");
  i.setAttribute('type', "hidden");
  i.setAttribute('name', "image[upload_cache]");

  form.appendChild(i);

  return form;
}

const imageUrlForm = (form, editable) => {

  // Creates text input for the content of the element and appends it to the form
  i = document.createElement("input");
  i.setAttribute('type', "text");
  i.setAttribute('name', "image[url]");
  i.setAttribute('autocomplete', "off");
  i.setAttribute('value', editable.querySelector('img').src);
  form.appendChild(i);

  return form;
}

const textForm = (form, editable) => {

  // Creates text input for the content of the element and appends it to the form
  i = document.createElement("textarea");
  i.setAttribute('type', "text");
  i.setAttribute('name', "text[inner_text]");
  i.setAttribute('autocomplete', "off");
  i.innerHTML = editable.innerText;
  i.setAttribute('value', editable.innerText);

  form.appendChild(i);

  return form;
}

const formForm = (form, editable) => {
  i = document.createElement("input");
  i.setAttribute('type', "text");
  i.setAttribute('name', "form[send_to]");
  i.setAttribute('value', editable.getAttribute("data-mail"))
  form.appendChild(i)
  return form
}


const createElementFromHTML = (htmlString) => {
  // Creates a node element from a HTML string
  const div = document.createElement('div');
  div.innerHTML = htmlString.trim();

  return div.firstChild;
}


// Selects the view's edit button and adds listener to toggle between edit and view mode
const editButton = document.getElementById('hera-edit-button');
if (editButton) {
  editButton.addEventListener('click', toggleEditLoader)
}
