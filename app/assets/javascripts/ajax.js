var proxy = function(method, url, responseType, params) {
  return new Promise(function(resolve, reject) {
    var xhr = new XMLHttpRequest();

    xhr.open(method, url);
    xhr.withCredentials = false;
    xhr.responseType = responseType;

    xhr.onload = function() {
      if (xhr.status === 200){
        resolve(xhr.response);
      } else {
        reject(console.log(xhr.statusText));
      }
    };

    xhr.onerror = function() {
      reject(console.log('Error'));
    }

    xhr.send(params);
  });
};