class Component {
  createElement(tag, className, attributes = {}, textContent = '') {
    const element = document.createElement(tag);
    if (className) {
      element.className = className;
    }
    Object.entries(attributes).forEach(([key, value]) => {
      element.setAttribute(key, value);
    });
    if (textContent) {
      element.textContent = textContent;
    }
    return element;
  }

  appendToParent(parentSelector, child) {
    const parent = document.querySelector(parentSelector);  // Corrected variable name
    if (parent) {
      parent.appendChild(child);
    } else {
      throw new Error(`Parent element "${parentSelector}" not found`);
    }
  }
}

export { Component };