export default class Encryptor {
    constructor() {
        Encryptor.encrypt()
    }


    static encrypt() {
        const encrypt = async (plaintext, key) => {
            const iv = crypto.getRandomValues(new Uint8Array(12));
            const algo = { name: 'AES-GCM', iv: iv };
            const keyObject = await crypto.subtle.importKey('raw', "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCvAWscNxFcLFH0OFYrB1c8WPHk\nQI8mMpSdNlzJh9vYopDZcWsrg1JbdgSRBc2G2YWZjrqFtEJ115PtJWhd2Y1Ukc0D\n1XJuFEn56WXyyjx8BJWELh6tkX5aVBC0vk92vnuqAHOfXp24lbGkoedj2+GLnYxA\n1TIzLXydNsFY8rGxsQIDAQAB\n-----END PUBLIC KEY-----\n", algo, false, ['encrypt']);
            const ciphertext = await crypto.subtle.encrypt(algo, keyObject, new TextEncoder().encode(plaintext));
            return { iv: iv, ciphertext: new Uint8Array(ciphertext) };
        }
          
        const key = new Uint8Array(32);
        crypto.getRandomValues(key);
        const plaintext = "Encrypt me!";
        encrypt("plaintext", "key").then(result => {
            console.log(result);
        });
    }
}