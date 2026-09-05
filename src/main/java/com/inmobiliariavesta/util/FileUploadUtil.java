package com.inmobiliariavesta.util;

import jakarta.servlet.http.Part;
import java.io.*;
import java.nio.file.*;
import java.util.UUID;

/**
 * Utilidad para subir archivos de imágenes (fotos de perfil y propiedades)
 */
public class FileUploadUtil {
    
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
    private static final String[] ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png", "gif", "webp"};
    
    /**
     * Guarda una imagen subida en la carpeta especificada
     * @param part El archivo subido desde el formulario multipart
     * @param uploadPath Ruta absoluta donde se guardará el archivo
     * @return El nombre del archivo guardado o null si hubo error
     */
    public static String saveImage(Part part, String uploadPath) {
        if (part == null || part.getSize() == 0) {
            return null;
        }
        
        try {
            // Validar tamaño
            if (part.getSize() > MAX_FILE_SIZE) {
                throw new IllegalArgumentException("El archivo excede el tamaño máximo de 10MB");
            }
            
            // Obtener nombre original y extraer extensión
            String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String extension = getFileExtension(fileName);
            
            // Validar extensión
            if (!isAllowedExtension(extension)) {
                throw new IllegalArgumentException("Tipo de archivo no permitido. Solo se permiten: JPG, PNG, GIF, WEBP");
            }
            
            // Generar nombre único para evitar colisiones
            String uniqueFileName = UUID.randomUUID().toString() + "_" + System.currentTimeMillis() + "." + extension;
            Path filePath = Paths.get(uploadPath, uniqueFileName);
            
            // Crear directorio si no existe
            Files.createDirectories(Paths.get(uploadPath));
            
            // Guardar archivo
            try (InputStream input = part.getInputStream();
                 FileOutputStream output = new FileOutputStream(filePath.toFile())) {
                
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }
            
            return uniqueFileName;
            
        } catch (IOException e) {
            throw new RuntimeException("Error al guardar la imagen: " + e.getMessage(), e);
        }
    }
    
    /**
     * Obtiene la extensión de un archivo
     */
    private static String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf(".");
        if (lastDotIndex == -1 || lastDotIndex == fileName.length() - 1) {
            return "";
        }
        return fileName.substring(lastDotIndex + 1).toLowerCase();
    }
    
    /**
     * Valida si la extensión está permitida
     */
    private static boolean isAllowedExtension(String extension) {
        for (String allowed : ALLOWED_EXTENSIONS) {
            if (allowed.equals(extension)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Elimina un archivo de imagen
     */
    public static boolean deleteImage(String uploadPath, String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return false;
        }
        
        try {
            Path filePath = Paths.get(uploadPath, fileName);
            return Files.deleteIfExists(filePath);
        } catch (IOException e) {
            return false;
        }
    }
}
