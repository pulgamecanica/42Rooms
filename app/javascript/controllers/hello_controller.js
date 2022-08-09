import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {

  }
  change_theme() {
    fetch("/change_theme", {
      method:'GET',
      dataType:"html",
      data: {},
      success:function(result){
        alert("Theme changed successfully :D");
      }
    });
  }
  items_per_page() {
    const urlParams = new URLSearchParams(window.location.search);
    let input = document.querySelector("#items_per_page");
    urlParams.set('page', '1');
    if (input.value != '' && input.value > 0)
      urlParams.set('limit', input.value);
    window.location.search = urlParams;
  }
}
