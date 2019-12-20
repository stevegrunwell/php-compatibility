#!/usr/bin/env bash

# Print basic usage instructions.
print_usage() {
  echo 'Download a package and check its compatibility with certain versions of PHP.';
  echo
  echo 'Usage:'
  echo -e "\t${0} <url> [options]"
  echo
  echo 'Options:'
  echo -e "\t-h,--help\tShow all available options."
  echo -e "\t--php\t\tThe PHP version (or range) to use for evaluation."
  echo -e "\t--report\tThe report style. For a full list of options, see:"
  echo -e "\t\t\thttps://github.com/squizlabs/PHP_CodeSniffer/wiki/Reporting"
  echo -e "\t\t\tDefault is \"full\"."
}

# Print example usage.
print_examples() {
  set -e
  echo 'Examples:'
  echo -e "\t# Test WordPress against PHP 7.4"
  echo -e "\t${0} https://wordpress.org/latest.zip --php=7.4"
}

# Parse arguments.
if [ $# = 0 ]; then
  print_usage
  exit 1
fi

PACKAGE_URL="$1"
PHP_VERSION="7.0-"
REPORT_STYLE="full"
shift

while [ $# -gt 0 ]; do
  case "$1" in
    --php=*)
      PHP_VERSION="${1#*=}"
      ;;
    --report=*)
      REPORT_STYLE="${1#*=}"
      ;;
    -h|--help|*)
      print_usage
      echo
      print_examples
      exit
      ;;
  esac
  shift
done

# Download the given URL.
wget -O /tmp/package.zip -q "$PACKAGE_URL"

# Unzip the archive into app/ and run PHP_CodeSniffer.
unzip -qq /tmp/package.zip -d src \
    && php ./vendor/bin/phpcs -q \
    --standard=phpcs.xml.dist \
    --runtime-set testVersion "$PHP_VERSION" \
    --report="$REPORT_STYLE" \
    src
