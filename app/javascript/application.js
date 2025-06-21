// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@rails/ujs"

Rails.start()

// Preview Image JS
document.addEventListener("DOMContentLoaded", () => {
  const imageInput = document.getElementById("image_input");
  const preview = document.getElementById("image_preview");

  if (imageInput) {
    imageInput.addEventListener("change", () => {
      preview.innerHTML = ""; // Clear previous preview

      const file = imageInput.files[0];
      if (file) {
        const reader = new FileReader();

        reader.onload = (e) => {
          const img = document.createElement("img");
          img.src = e.target.result;
          img.style.maxWidth = "150px";
          img.style.maxHeight = "150px";
          preview.appendChild(img);
        };

        reader.readAsDataURL(file);
      }
    });
  }
});

