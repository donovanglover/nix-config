GPG, also known as the GNU Privacy Guard, is a free and open source implementation of the OpenPGP standard.

# Creating Keys

- Key: RSA and RSA
- Keysize: 4096 bits
- Valid for: 1y (1 year)

## Encrypting Files

- Encrypt <IN> with a password and output the results to <OUT>: `gpg -c <IN> -o <OUT>`

## Decrypting Files

- Decrypt <IN> and output the results to <OUT>: `gpg -d <IN> -o <OUT>`
- Decrypt <IN> `gpg <filename>`
