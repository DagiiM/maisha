

const applyStylesFromFile = (fileName) => {
  const cssPath = `../static/mvc/vitals/styles/${fileName}.css`;
  const link = document.createElement('link');
  link.rel = 'stylesheet';
  link.type = 'text/css';
  link.href = cssPath;
  document.head.appendChild(link);
};

const updateReferenceContainer = (container) => {
    container.innerHTML = '';
    return container;
}

  export {applyStylesFromFile,updateReferenceContainer};

