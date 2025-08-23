-- Tabla de usuarios actualizada con todos los campos requeridos por el CRUD
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    ciudad_residencia VARCHAR(100),
    contraseña VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT NOW(),
    avatar_url VARCHAR(255),
    nivel_viajero INT DEFAULT 1
);

CREATE TABLE destinos (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    nombre_lugar VARCHAR(100) NOT NULL,
    pais VARCHAR(50) DEFAULT 'Colombia',
    descripcion_general TEXT,
    imagen_principal VARCHAR(255),
    latitud DECIMAL(10, 8),
    longitud DECIMAL(11, 8),
    promedio_calificacion DECIMAL(2,1) DEFAULT 0.0
);

CREATE TABLE culturas (
    id_cultura INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL, -- gastronomía, costumbre, evento, etc.
    descripcion TEXT,
    id_destino INT NOT NULL,
    imagen_url VARCHAR(255),
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) ON DELETE CASCADE
);

CREATE TABLE zonas_peligrosas (
    id_zona INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sector VARCHAR(100) NOT NULL,
    nivel_riesgo VARCHAR(50) NOT NULL, -- bajo, medio, alto, extremo
    descripcion TEXT,
    id_destino INT NOT NULL,
    latitud DECIMAL(10, 8),
    longitud DECIMAL(11, 8),
    ultima_actualizacion DATETIME,
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) ON DELETE CASCADE
);

CREATE TABLE hoteles (
    id_hotel INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    id_destino INT NOT NULL,
    categoria INT, -- Estrellas (1-5)
    precio_promedio DECIMAL(10, 2),
    imagen_url VARCHAR(255),
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) ON DELETE CASCADE
);

CREATE TABLE comidas (
    id_comida INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_destino INT NOT NULL,
    tipo VARCHAR(50), -- Plato típico, bebida, etc.
    imagen_url VARCHAR(255),
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) ON DELETE CASCADE
);

CREATE TABLE itinerarios (
    id_itinerario INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE,
    notas TEXT,
    fecha_creacion DATETIME DEFAULT NOW(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE itinerario_destinos (
    id_itinerario_destino INT AUTO_INCREMENT PRIMARY KEY,
    id_itinerario INT NOT NULL,
    id_destino INT NOT NULL,
    orden_visita INT,
    notas TEXT,
    FOREIGN KEY (id_itinerario) REFERENCES itinerarios(id_itinerario) ON DELETE CASCADE,
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) ON DELETE CASCADE
);

CREATE TABLE viajes (
    id_viaje INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_destino INT NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE,
    id_hotel INT,
    calificacion INT CHECK (calificacion >= 1 AND calificacion <= 5),
    comentarios TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) ON DELETE CASCADE,
    FOREIGN KEY (id_hotel) REFERENCES hoteles(id_hotel) ON DELETE SET NULL
);

CREATE TABLE consultas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    asunto VARCHAR(100) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_consulta DATETIME DEFAULT NOW(),
    estado VARCHAR(20) DEFAULT 'pendiente',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE noticias_zonas (
    id_noticia INT AUTO_INCREMENT PRIMARY KEY,
    id_zona INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT,
    fecha_publicacion DATETIME DEFAULT NOW(),
    fuente VARCHAR(100),
    FOREIGN KEY (id_zona) REFERENCES zonas_peligrosas(id_zona) ON DELETE CASCADE
);

CREATE TABLE favoritos (
    id_favorito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo_objeto VARCHAR(50) NOT NULL, -- hotel, comida, destino
    id_objeto INT NOT NULL,
    fecha_agregado DATETIME DEFAULT NOW(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE calificaciones (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo_objeto VARCHAR(50) NOT NULL, -- destino, hotel, comida
    id_objeto INT NOT NULL,
    puntuacion INT NOT NULL CHECK (puntuacion >= 1 AND puntuacion <= 5),
    comentario TEXT,
    fecha_calificacion DATETIME DEFAULT NOW(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Índices para mejorar el rendimiento
CREATE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_destinos_pais ON destinos(pais);
CREATE INDEX idx_viajes_usuario ON viajes(id_usuario);
CREATE INDEX idx_viajes_destino ON viajes(id_destino);
CREATE INDEX idx_favoritos_usuario ON favoritos(id_usuario);
CREATE INDEX idx_calificaciones_usuario ON calificaciones(id_usuario);

-- Comentario final: Script listo para importar en MySQL