# Not Another BashTools!

Not Another BashTools! (NABT) is yet another set of tools and utilities to help you better manage your bash shell environment.

## How To Use

Use the following one-liner to install it to your home directory (which uses curl):

```shell
cd ~ && mkdir -p not_another_bashtools && curl -L https://github.com/skcin7/not_another_bashtools/raw/master/dist/0.0.1-alpha.tar.gz | tar -xz -C not_another_bashtools
```

Now, add the following code to your `.bash_profile` or `.bashrc`:

```shell
export NABT_PATH="$HOME/not_another_bashtools"
source "${NABT_PATH}/nabt.bootstrapper.bash"
```

## Contributing

To contribute... TODO