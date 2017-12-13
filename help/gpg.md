GPG, also known as the GNU Privacy Guard, is a free and open source implementation of the OpenPGP standard.

## Using GPG

- You give your *public key* to others so that they can send encrypted messages to you.
- You use your *private key* to create a *digital signature* that verifies your identity.

Your public key and private key are connected to each other. When you combine the two, it becomes possible to write encrypted messages specifically for a specific person as well as verify that a specific person has signed a document or other content.

More specifically,

- Other people use your **public key** to:
    1. **Write** encrypted content to you.
    2. **Verify** that a signature actually came from you.
- You use your **private key** to:
    1. **Read** encrypted content that people send to you.
    2. **Sign** documents and other content, verifying their authenticity.

### Naming Conventions

- `.key` files are used to store public GPG keys.
- `.gpg` files are used to store encrypted contents in binary format.
- `.asc` files are used to store encrypted contents in ASCII format.
- `.sig` files are used to store GPG signatures created with private keys. They may or may not also include the file content in a compressed or plain text format. Note that `.sig` files are **NOT** encrypted.

**NOTE**: Signed files that are not encrypted may still be stored as `.gpg` or `.asc`. As a convention that I made up, you should use `.sig.gpg` to signify a signature that has binary-encrypted content and `.sig.asc` to signify a signature that is ASCII-encrypted.

### Sending Messages

1. Someone receives your public GPG key and verifies that the key is actually yours.
    - TODO: Add process of verification here.
2. They use your public key to encrypt a message that they send to you.
3. They include their public key in the encrypted message so that you can send an encrypted message back to them.
4. You receive the encrypted message.
5. You use your private key to decrypt the message.
6. You use the public key that they sent you to send an encrypted message back to them.

## Creating Keys

- Use RSA for the sign only key and RSA for the encrypt only key
- Use a keysize of 4096 bits
- Make the key valid for one year (1y)
- Do not put anything for the comments field
    - More information: [OpenPGP User ID Comments considered harmful](https://debian-administration.org/users/dkg/weblog/97)

## Common Commands

- Generate a new key pair: `gpg --full-gen-key`
- List all keys in your public keyring: `gpg --list-keys`
- List all keys in your private keyring: `gpg --list-secret-keys`
- Export a public key: `gpg -a --export <user_id>`
    - `-a` is shorthand for `--armor`, which creates ASCII output as opposed to the usual binary format
    - If you want to output the public key to a file instead of printing it, use: `-o <keyfile>`
    - Often used so other people can send messages to you with your public key
- Import a public key: `gpg --import <keyfile>`
    - Used so that you can send encrypted messages to other people with their public key
- Check the fingerprint of a keyfile: `gpg --with-fingerprint <keyfile>`

**NOTE**: If you import a public key from a keyfile, then you should first check that the fingerprint matches a verified source published by the expected owner of that key *before* adding it.

## Using a Keyserver

- Add a public key to the keyserver (permanent): `gpg --send-keys <user_id>`
- View the details of a key on the keyserver: `gpg --search-keys <user_id>`
- Import a key from the keyserver: `gpg --recv-key <fingerprint>`

**NOTE**: You should always verify the authenticity of a retrieved public key by comparing its *fingerprint* with one the owner published on at least one *independent source*.

**NOTE**: Never use a short ID when requesting keys from a keyserver. There have been attacks in the past that abuse the fact that it's trivial to create multiple keys with the same short ID. The long key ID is also prone to this attack. Instead, always use the full fingerprint when receiving a key.
- More Information: [OpenPGP Key IDs are not useful](https://debian-administration.org/users/dkg/weblog/105)
- Also see: [Evil 32: Check Your GPG Fingerprints](https://evil32.com)

## Encrypting and Decrypting Things

- Encrypt a file with someone else's public key: `gpg -R <user_id> -e <file>`
    - This ensures that only they should be able to read the message and no one else. It is not trivial to guess a private key, making it much harder to brute force than a password.
    - If you want to encrypt your own files, you can use use `-R <your_user_id>` so that only your private key can decrypt it.
    - **NOTE**: You should add `-a` before `-e` if you want the encrypted output to be ASCII and not binary.
    - **NOTE**: You should always use `-R` (hidden-recipient) instead of `-r` to avoid putting the recipient key IDs in the encrypted message.
    - **NOTE**: If your config does not remove the version number by default, then you should add **--no-emit-version** to avoid giving away version information.
- Encrypt a file with a password: `gpg -c <file> -o <output_file>`
    - Similar to above, you should also add `-a` before `-c` if you want the encrypted output to be in ASCII and not binary.
- Decrypt a file and save the results: `gpg -d <file> -o <output_file>`
- Decrypt a file and print the contents: `gpg -d <file>`

**NOTE**: Using a password to encrypt a file is not as secure as using a public key since a password can be easily solved in trivial time.

## Key Security

- Backup your private key: `gpg -a --export-secret-keys <user_id> > privkey.asc`
- Import a backup of your private key: `gpg --import privkey.asc`

### Editing your key

- Open the GPG shell: `gpg --edit-key <user_id>`
    - `passwd`: Change the passphrase of your GPG key
    - `clean`: Compact any user ID that is no longer usable (e.g. revoked or expired)
    - `revkey`: Revoke a key or subkey
    - `addkey`: Add a subkey to this key
    - `expire`: Change the key expiration time
    - `quit`: Close the GPG shell
    - `save`: Save your changes and quit
    - `fpr`: Show the key fingerprint

**NOTE**: To add an email address to your GPG key, use `adduid`. You can set your preferred email address with `primary`.

### Using Multiple Devices

If you want to use your GPG key on multiple devices, then you should strip out the master key and only use subkeys on less secure systems.

1. Get the ID of the subkey you want to export: `gpg -K`
2. Export that subkey: `gpg -a --export-secret-subkeys <subkey_id>! > /tmp/subkey.gpg`

**NOTE**: The `!` after `<subkey_id>` is very important. Without it, all of your subkeys would be exported instead of just the one you specified.

Now that you have a copy of the subkey, you need to change its password.

1. Create a temporary import: `gpg --homedir /tmp/gpg --import /tmp/subkey.gpg`
2. Edit the key (in its temporary location): `gpg --homedir /tmp/gpg --edit-key <user_id>`
    - Change the password: `passwd`
    - Save changes: `save`
3. Export the *final* subkey, ready for use on a different device: `gpg --homedir /tmp/gpg -a --export-secret-subkeys <subkey_id>! > /tmp/subkey.alt.gpg`

### Dealing with subkeys

**Never** delete your expired or revoked subkeys. This makes it impossible to decrypt files encrypted with the old subkey. **Only** delete expired or revoked keys from other users to clean your keyring.

Remember to extend your expiration dates. This shows that the key is still active and being used by its holder. A key with no expiration date is not trustworthy.

You should have a separate subkey for e.g. signing an email message and signing another key. This helps separate the two keys in case one gets compromised.

## Signing Things

A GPG signature is used to cerify and timestamp documents and other files. If the file is modified, verification of the signature will fail.

- Sign a file and compress it: `gpg -s <file> -o <file.sig>`
    - Note that `-s` is an alias for `--sign`. Use whichever you prefer.
    - Note that you must specify the output to be a `.sig` file.

**NOTE**: A signed file is **NOT** encrypted. To encrypt a signed file, use `gpg -R <user_id> -e <file.sig>` on the `.sig` file as usual.

**NOTE**: If you want to sign something but still have the format readable (e.g. if you want everyone to read the content and be able to confirm that it actually comes from you), then use `--clearsign` instead of `--sign`. Note that `-o` must be passed before `--clearsign` if you use this method.

### Using a Detached Signature

A detached signature creates a separate signature file. This allows you to share the signature separately from the document or file itself.

- Create a detached signature: `gpg --detach-sig <file> -o <file.sig>`
    - This is the preferred method when distributing software and other critical information where changes to the file would be detrimental.
    - A detached signature is useful for software, images, and other files that aren't plain text.
    - This allows the user to verify that a program, file, or other content has not been modified by a third party.

**NOTE**: If you want to make your signature ASCII readable, be sure to add `-a` when creating it.

## Verifying Signatures

How can you make sure that you received the right file or other content? With signatures!

- Verify a signature: `gpg --verify <sig_file>`
    - Note that if the contents of the file is not included in the `<sig_file>`, GPG will assume that the file to verify is the file in the same directory without `.sig`.
    - If for some reason you need to verify a file that doesn't follow this naming convention (should never happen), add the file to verify after `<sig_file>`.

**NOTE**: If a file has been encrypted and signed (i.e. `file.sig.gpg` and `file.sig.asc`), you should first decrypt the file then verify the signature separately.

## Encrypting Your Own Files

- `gpg -e -a -r <user_id> <file>`

## Revoking a Key

**NOTE**: Anyone with access to your revocation certificate can revoke your key, rendering it useless. You should only revoke a key if it is compromised, lost, or you forgot your passphrase.

- Revoking the key: `gpg --import <fingerprint>.rev`
- Updating the keyserver: `gpg --keyserver <keyserver> --send-keys <user_id>`
