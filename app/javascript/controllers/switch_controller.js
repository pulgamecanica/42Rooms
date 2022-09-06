import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="switch"
export default class extends Controller {
  connect() {
  }

  change_page(event) {
    let option = this.element.dataset.option;
    let buttons_children = this.element.parentElement.children;
    let content = document.querySelector('#switch_page' + option);
    let content_children = document.querySelector('#switch_content').children;
    if (!buttons_children || !content || !content_children)
      return;
    this.element.classList.remove('label-contrast');
    this.element.classList.add('label-blue');
    for (let i = buttons_children.length - 1; i >= 0; i--) {
      if (buttons_children[i].classList.contains('label-blue') && buttons_children[i] != this.element) {
        buttons_children[i].classList.remove('label-blue');
        buttons_children[i].classList.add('label-contrast');
      }
    }
    for (let i = content_children.length - 1; i >= 0; i--) {
      if (content_children[i] != content) {
        content_children[i].classList.remove('d-block');
        content_children[i].classList.add('d-none');
      }
    }
    content.classList.remove('d-none');
    content.classList.add('d-block');
  }
}
