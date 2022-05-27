# Not Another BashTools!

## How To Use

Use the following one-liner to install it to your home directory (which uses `curl`):

```shell
cd ~ && mkdir -p not_another_bashtools && curl -L https://github.com/skcin7/not_another_bashtools/releases/download/v0.0.1-alpha/0.0.1-alpha.tar.gz | tar -xz -C not_another_bashtools
```

Now, add the following code to your `.bash_profile` or `.bashrc`:

```shell
export NABT__PATH="$HOME/not_another_bashtools"
source "${NABT__PATH}/nabt.bootstrapper.bash"
```

## Contributing

To contribute... TODO