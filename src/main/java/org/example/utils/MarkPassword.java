package org.example.utils;

public class MarkPassword {
        public static String maskPassword(String password) {
            if (password == null) {
                return null;
            }
            return "*".repeat(password.length());
        }
}
