# PHP Compatibility

This Docker image is designed to safely download, extract, and analyze PHP packages using [the PHP Compatibility ruleset for PHP_CodeSniffer](https://github.com/PHPCompatibility/PHPCompatibility).

## Usage

The container has one goal: to download an archive of a package, safely extract it, then report if anything is incompatible with the target version(s) of PHP.

```sh
# Check against the Akismet WordPress plugin.
$ docker run --rm -it stevegrunwell/php-compatibility \
  https://downloads.wordpress.org/plugin/akismet.4.1.3.zip

# Verify that a package doesn't have issues with PHP 7.4
$ docker run --rm -it stevegrunwell/php-compatibility \
  https://example.com/some-package.zip --php=7.4
```

### Specifying the PHP version

By default, this tool will check for anything that might prevent the given package from being run on PHP 7.x (e.g. `--php=7.0-`), but the `--php` option will let you change the `testVersion` configuration for the [PHP Compatibility ruleset](https://github.com/PHPCompatibility/PHPCompatibility#sniffing-your-code-for-compatibility-with-specific-php-versions).
