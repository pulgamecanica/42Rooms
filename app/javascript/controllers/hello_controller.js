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
}
