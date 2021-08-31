package it.kernelpanic.unitopandemic.security;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.spec.AlgorithmParameterSpec;

/**
 * Class for the symmetric encryption and decryption of data using the ChaCha20 symmetric cryptographic algorithm
 * The choice of this algorithms is mainly due to its efficiency and its better toughness compared to an AES-256
 * algorithms.
 * We use the combination ChaCha20-Poly1305 that gets the simple ChaCha20 and combine it with the Poly1305 algorithm
 * to ensure greater security in the encryption process.
 * The specification of this algorithm in Java is implemented only in Java 11, therefore, no previous Java version can
 * be used.
 */
public class SymmetricCrypto {

    /*
     * The nonce need to be specified as a new byte[12], otherwise an IllegalArgumentException will be thrown
     * and it can't be null, or a NullPointerException will be thrown.
     */
    private final static byte[] nonce = new byte[12];

    /**
     * Encrypt function for the original text. It accept a text as a sequence of byte (conversion must happen
     * before invoking the method). It then returns the corresponding encrypted text as a sequence of byte.
     * The ChaCha20 specification for the encryption and decryption has been added into the Java ecosystem only
     * with Java11; as such, every project that will use this class to add a cryptographic layer of security into the
     * project will require at least that version.
     *
     * @param plaintext original text to be encrypted
     * @param key secret key to be used (either self generated or hard coded). In Java11, only 256 bit keys can be used
     * @return the encrypted text as byte
     * @throws Exception in case of error
     */
    public static byte[] encrypt(byte[] plaintext, byte[] key) throws Exception {

        /*
         * Cipher instance for the algorithm
         */
        Cipher cipher = Cipher.getInstance("ChaCha20-Poly1305/None/NoPadding");

        /*
         * Parameter spec define in the Java11 JDK, it requires the nonce
         */
        AlgorithmParameterSpec parameterSpec = new IvParameterSpec(nonce);

        /*
         * Creating the specification for the secret key. We encode it to be used with ChaCha20.
         * As per Java11 only 256 bit keys can be used
         */
        SecretKeySpec secretKeySpec = new SecretKeySpec(key, "ChaCha20");

        /*
         * Initializing the cipher object in encryption mode using the parameter specification for the key and the
         * encryption. The mode is ENCRYPT_MODE
         */
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, parameterSpec);

        return cipher.doFinal(plaintext);
    }

    /**
     * Encrypt function for the original text. It accept a text as a sequence of byte (encrypted text are already
     * sequences of byte). It then returns the corresponding decrypted text as a String.
     * The ChaCha20 specification for the encryption and decryption has been added into the Java ecosystem only
     * with Java11; as such, every project that will use this class to add a cryptographic layer of security into the
     * project will require at least that version.
     *
     * @param cipherText text encrypted to be decrypted
     * @param key secret key to be used (either self generated or hard coded). In Java11, only 256 bit keys can be used
     * @return the decrypted text as String
     * @throws Exception in case of error
     */
    public static String decrypt(byte[] cipherText, byte[] key) throws Exception {

        /*
         * Cipher instance for the algorithm
         */
        Cipher cipher = Cipher.getInstance("ChaCha20-Poly1305/None/NoPadding");

        /*
         * Parameter spec define in the Java11 JDK, it requires the nonce
         */
        AlgorithmParameterSpec parameterSpec = new IvParameterSpec(nonce);

        /*
         * Creating the specification for the secret key. We encode it to be used with ChaCha20.
         * As per Java11 only 256 bit keys can be used
         */
        SecretKeySpec secretKeySpec = new SecretKeySpec(key, "ChaCha20");

        /*
         * Initializing the cipher object in decryption mode using the parameter specification for the key and the
         * decryption. The mode is DECRYPT_MODE
         */
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, parameterSpec);

        return new String(cipher.doFinal(cipherText));
    }
}
