package Helper;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordHelper {

    // Call this when saving a password (register / change password)
    public static String hash(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    // Call this when checking login — compares plain text to hashed
    public static boolean verify(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}