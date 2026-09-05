package com.inmobiliariavesta.util;

import org.mindrot.jbcrypt.BCrypt;

public class BCryptUtil {

    private static final int LOG_ROUNDS = 10;

    /**
     * Genera un hash seguro para una contraseña en texto plano usando BCrypt.
     */
    public static String hashPassword(String plainTextPassword) {
        if (plainTextPassword == null || plainTextPassword.isBlank()) {
            throw new IllegalArgumentException("La contraseña no puede estar vacía.");
        }
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(LOG_ROUNDS));
    }

    /**
     * Valida si una contraseña en texto plano coincide con el hash BCrypt guardado.
     */
    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        if (plainTextPassword == null || hashedPassword == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainTextPassword, hashedPassword);
        } catch (Exception e) {
            System.err.println("[BCryptUtil] Error verificando contraseña: " + e.getMessage());
            return false;
        }
    }
}
