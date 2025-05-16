<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!-- Carrusel de imágenes -->
<div class="container mt-4 carousel-container">
    <div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="/api/placeholder/1200/300" class="d-block w-100" alt="Slide 1">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Novedades</h5>
                    <p>Descubre nuestros últimos productos.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="/api/placeholder/1200/300" class="d-block w-100" alt="Slide 2">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Ofertas especiales</h5>
                    <p>Aprovecha nuestros descuentos.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="/api/placeholder/1200/300" class="d-block w-100" alt="Slide 3">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Envío gratis</h5>
                    <p>En pedidos superiores a 50€.</p>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Anterior</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Siguiente</span>
        </button>
    </div>
</div>