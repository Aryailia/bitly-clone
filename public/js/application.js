(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function () {
    refreshList('display');
    document.getElementById('mini').addEventListener('submit', function () {
      submit(document.getElementById('link').value, 'mini', 'display');
    });
  });

  function submit(text, formId, displayID) {
    var form = new FormData(document.getElementById(formId))
    fetch('/submit', { method: 'post', body: form }).then(function (response) {
      return response.text();
    }).then(function (text) {
      //refreshList(id);
      document.getElementById(displayID).innerHTML = text;
      //console.log('asdf')
    }).catch(function (err) {
      document.getElementById(displayID).innerHTML = err;
    });
  }

  function refreshList(id) {
    fetch('/list', { method: 'get' }).then(function (response) {
      return response.text();
    }).then(function (text) {
      var display = document.getElementById(id);
      display.innerHTML = text;
    }).catch(function (err) {
      display.innerHTML = err;
    });
  }
})();