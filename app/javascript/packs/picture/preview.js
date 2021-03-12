document.addEventListener('DOMContentLoaded', () => {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        document.getElementById('pic_preview').setAttribute('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  document.getElementById('pic_field').addEventListener('change', function (e) {
    readURL(this);
  });
})