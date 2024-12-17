<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrusel de Imágenes con Enlaces</title>
    <style>
        .carousel-container {
            width: 100%;
            overflow: hidden;
            position: relative;
        }

        .carousel {
            display: flex;
            transition: transform 1s ease;
        }

        .carousel-item {
            min-width: 100%;
        }

        .carousel-item img {
            width: 100%;
            height: auto;
            display: block;
            cursor: pointer; /* Añadido para mostrar que es clickeable */
        }

        /* Estilo para el botón de edición */
        #editButton {
            display: none; /* El botón está oculto por defecto */
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 10px 20px;
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            z-index: 1000;
        }

        /* Estilo para el cuadro de entrada de nuevas URLs de imágenes y enlaces */
        #imageURLsInput, #imageLinksInput {
            position: absolute;
            top: 100px;
            left: 20px;
            background-color: white;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            display: none;
        }

        #imageURLsInput input, #imageLinksInput input {
            margin-bottom: 10px;
            width: 200px;
        }

        #imageURLsInput button, #imageLinksInput button {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="carousel-container">
    <div class="carousel">
        <div class="carousel-item">
            <img id="image1" src="https://example.com/imagen1.jpg" alt="Imagen 1" onclick="openLink(1)">
        </div>
        <div class="carousel-item">
            <img id="image2" src="https://example.com/imagen2.jpg" alt="Imagen 2" onclick="openLink(2)">
        </div>
        <div class="carousel-item">
            <img id="image3" src="https://example.com/imagen3.jpg" alt="Imagen 3" onclick="openLink(3)">
        </div>
    </div>
</div>

<!-- Botón de editar imágenes y enlaces (Oculto por defecto) -->
<button id="editButton" onclick="enableEditing()">Editar Imágenes y Enlaces</button>

<!-- Cuadro para ingresar las nuevas URLs de las imágenes -->
<div id="imageURLsInput">
    <label for="url1">URL de la Imagen 1:</label>
    <input type="text" id="url1" value="https://example.com/imagen1.jpg"><br>
    <label for="url2">URL de la Imagen 2:</label>
    <input type="text" id="url2" value="https://example.com/imagen2.jpg"><br>
    <label for="url3">URL de la Imagen 3:</label>
    <input type="text" id="url3" value="https://example.com/imagen3.jpg"><br>
    <button onclick="updateImages()">Actualizar Imágenes</button>
</div>

<!-- Cuadro para ingresar las nuevas URLs de destino para las imágenes -->
<div id="imageLinksInput">
    <label for="link1">Enlace de la Imagen 1:</label>
    <input type="text" id="link1" value="https://example.com/destino1"><br>
    <label for="link2">Enlace de la Imagen 2:</label>
    <input type="text" id="link2" value="https://example.com/destino2"><br>
    <label for="link3">Enlace de la Imagen 3:</label>
    <input type="text" id="link3" value="https://example.com/destino3"><br>
    <button onclick="updateLinks()">Actualizar Enlaces</button>
</div>

<script>
    let currentIndex = 0;
    const items = document.querySelectorAll('.carousel-item');
    const totalItems = items.length;
    let links = {
        1: 'https://example.com/destino1',
        2: 'https://example.com/destino2',
        3: 'https://example.com/destino3'
    };

    // Función para cambiar la imagen cada 5 segundos
    function showNextImage() {
        currentIndex = (currentIndex + 1) % totalItems;
        const newTransformValue = -currentIndex * 100;
        document.querySelector('.carousel').style.transform = `translateX(${newTransformValue}%)`;
    }

    setInterval(showNextImage, 5000); // Cambia cada 5 segundos
    window.onload = showNextImage;

    // Detectar si la página está en modo de edición de SharePoint
    function isPageInEditMode() {
        return typeof _spPageContextInfo !== "undefined" && _spPageContextInfo.pageEditMode === true;
    }

    // Mostrar el botón de edición solo en modo de edición
    if (isPageInEditMode()) {
        document.getElementById('editButton').style.display = 'block';
    }

    // Función para habilitar la edición de imágenes y enlaces
    function enableEditing() {
        document.getElementById('imageURLsInput').style.display = 'block';
        document.getElementById('imageLinksInput').style.display = 'block';
    }

    // Función para actualizar las imágenes del carrusel
    function updateImages() {
        const url1 = document.getElementById('url1').value;
        const url2 = document.getElementById('url2').value;
        const url3 = document.getElementById('url3').value;

        document.getElementById('image1').src = url1;
        document.getElementById('image2').src = url2;
        document.getElementById('image3').src = url3;

        // Ocultar el cuadro de entrada después de actualizar
        document.getElementById('imageURLsInput').style.display = 'none';
    }

    // Función para actualizar las URLs de destino
    function updateLinks() {
        links[1] = document.getElementById('link1').value;
        links[2] = document.getElementById('link2').value;
        links[3] = document.getElementById('link3').value;

        // Ocultar el cuadro de entrada después de actualizar
        document.getElementById('imageLinksInput').style.display = 'none';
    }

    // Función para abrir el enlace de destino cuando se hace clic en la imagen
    function openLink(imageIndex) {
        const url = links[imageIndex];
        if (url) {
            window.open(url, '_blank');
        }
    }
</script>

</body>
</html>
