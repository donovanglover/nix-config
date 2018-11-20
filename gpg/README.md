# GPG

GPG is the standard encryption tool.

## Use Cases

gpg can be used to:

- Sign things with your signing subkey
- Read encrypted messages sent to you with your encryption subkey
- Send encrypted messages to other people with their public key
- Verify the authenticity of someone's messages and other data with their public key

You should not use gpg if:

- You should use gpg.

## Usage

Export `GPG_TTY` in your shell's init script. This is how you would do it in [fish](/fish):

```fish
export GPG_TTY=(tty)
```

[gnupg]: https://github.com/gpg/gnupg
